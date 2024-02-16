use axum::{
    async_trait,
    body::{Body, Bytes},
    extract::{FromRequest, Request},
    http::StatusCode,
    middleware::{self, Next},
    response::{IntoResponse, Response},
    routing::{get, post},
    Router,
};
use tower_http::trace::{self, TraceLayer};
use tower_http::cors::CorsLayer;
use tracing::{info, Level};
use tracing_appender::rolling;
use http_body_util::BodyExt;
use tracing_subscriber::fmt::writer::MakeWriterExt;

mod db;
mod api;

#[tokio::main]
async fn main() {
    dotenv::dotenv().ok();

    // tracing_subscriber::registry()
    //     .with(
    //         tracing_subscriber::EnvFilter::try_from_default_env()
    //             .unwrap_or_else(|_| "example_consume_body_in_extractor_or_middleware=debug".into()),
    //     )
    //     .with(tracing_subscriber::fmt::layer())
    //     .init();

    let log_file = rolling::daily("./logs", "debug")
        .with_max_level(tracing::Level::DEBUG);

    tracing_subscriber::fmt()
        .with_writer(log_file)
        .with_ansi(false)
        .with_env_filter(tracing_subscriber::EnvFilter::from_default_env())
        .init();

    let pool = db::establish_connection().await;

    let app = Router::new()
        .route("/api/login", post(api::user::login))
        .route("/api/get_user_info", get(api::user::get_user_info))
        .route("/api/change_user_info", post(api::user::change_user_info))
        .route("/api/get_teacher_list", post(api::info::get_teacher_list))
        .route("/api/get_reason_list", get(api::info::get_reason_list))
        .route("/api/add_reason_list", post(api::info::add_reason_list))
        .route("/api/delete_reason_list", post(api::info::delete_reason_list))
        .route("/api/change_password", post(api::user::change_password))
        .route("/api/change_img", post(api::user::change_img))
        .route("/api/send_suggestion", post(api::info::send_suggestion))
        .route("/api/get_valid_teacher", get(api::info::get_valid_teacher))
        .route("/api/get_user_list", get(api::info::get_user_list))
        .route("/api/send_message", post(api::message::send_message))
        .route("/api/get_messages", get(api::message::get_messages))
        .layer(CorsLayer::permissive())
        .layer(TraceLayer::new_for_http()
            .make_span_with(trace::DefaultMakeSpan::new().level(Level::DEBUG))
            .on_response(trace::DefaultOnResponse::new().level(Level::DEBUG)),
        )
        .layer(middleware::from_fn(print_request_body))
        .with_state(pool);

    let listener = tokio::net::TcpListener::bind("127.0.0.1:3000")
        .await
        .unwrap();
    info!("server listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.unwrap();
}

// middleware that shows how to consume the request body upfront
async fn print_request_body(request: Request, next: Next) -> Result<impl IntoResponse, Response> {
    let request = buffer_request_body(request).await?;

    Ok(next.run(request).await)
}

// the trick is to take the request apart, buffer the body, do what you need to do, then put
// the request back together
async fn buffer_request_body(request: Request) -> Result<Request, Response> {
    let (parts, body) = request.into_parts();

    // this wont work if the body is an long running stream
    let bytes = body
        .collect()
        .await
        .map_err(|err| (StatusCode::INTERNAL_SERVER_ERROR, err.to_string()).into_response())?
        .to_bytes();

    do_thing_with_request_body(bytes.clone());

    Ok(Request::from_parts(parts, Body::from(bytes)))
}

fn do_thing_with_request_body(bytes: Bytes) {
    tracing::debug!(body = ?bytes);
}

// extractor that shows how to consume the request body upfront
struct BufferRequestBody(Bytes);

// we must implement `FromRequest` (and not `FromRequestParts`) to consume the body
#[async_trait]
impl<S> FromRequest<S> for BufferRequestBody
where
    S: Send + Sync,
{
    type Rejection = Response;

    async fn from_request(req: Request, state: &S) -> Result<Self, Self::Rejection> {
        let body = Bytes::from_request(req, state)
            .await
            .map_err(|err| err.into_response())?;

        do_thing_with_request_body(body.clone());

        Ok(Self(body))
    }
}

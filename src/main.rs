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
use tokio::signal;
use tower_http::trace::{self, TraceLayer};
use tower_http::cors::CorsLayer;
use tracing::{info, Level};
use tracing_appender::rolling;
use http_body_util::BodyExt;
use tracing_subscriber::fmt::writer::MakeWriterExt;

mod db;
mod api;

use anyhow::{anyhow, Result};

async fn start_server() -> Result<()> {
    dotenv::dotenv().ok();

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
        .route("/api/send_student_info", post(api::chouxiang::send_student_info))
        .route("/api/get_student_info", post(api::chouxiang::get_student_info))
        .route("/api/send_sign", post(api::chouxiang::send_sign))
        .route("/api/get_sign", post(api::chouxiang::get_sign))
        .route("/api/exam_selection", post(api::chouxiang::exam_selection))
        .route("/api/set_exam_time", post(api::chouxiang::set_exam_time))
        .route("/api/set_start_end_date", post(api::chouxiang::set_start_end_date))
        .route("/api/withdraw", post(api::chouxiang::withdraw))
        .route("/api/get_select", get(api::chouxiang::get_select))
        .route("/api/send_two_way_table", post(api::chouxiang::send_two_way_table))
        .route("/api/get_two_way_table", post(api::chouxiang::get_two_way_table))
        .route("/api/get_suggestions", get(api::info::get_suggestions))
        .route("/api/get_unmatched", get(api::chouxiang::get_unmatched))
        .route("/api/set_matched_data", post(api::chouxiang::set_matched_data))
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

    axum::serve(listener, app)
        .with_graceful_shutdown(shutdown_signal())
        .await
        .unwrap();

    Err(anyhow!("BANG"))
}

#[tokio::main]
async fn main() {
    match start_server().await {
        Err(e) => {
            info!("Server failed to start: {:?}", e);
        }
        Ok(_) => {
            info!("Server started");
        }
    }
}

async fn shutdown_signal() {
    let ctrl_c = async {
        signal::ctrl_c()
            .await
            .expect("failed to install Ctrl+C handler");
    };

    #[cfg(unix)]
    let terminate = async {
        signal::unix::signal(signal::unix::SignalKind::terminate())
            .expect("failed to install signal handler")
            .recv()
            .await;
    };

    #[cfg(not(unix))]
    let terminate = std::future::pending::<()>();

    tokio::select! {
        _ = ctrl_c => {
            println!("Ctrl+C received");
        },
        _ = terminate => {
            println!("Terminate signal received");
        },
    }
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

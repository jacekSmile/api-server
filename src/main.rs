use axum::{
    routing::{get, post},
    Router,
};
use tower_http::trace::TraceLayer;
use tracing::info;

mod db;
mod api;

#[tokio::main]
async fn main() {
    dotenv::dotenv().ok();
    tracing_subscriber::fmt().init();

    let pool = db::establish_connection().await;

    let app = Router::new()
        .route("/api/login", post(api::user::login))
        .route("/api/get_user_info", get(api::user::get_user_info))
        .route("/api/change_user_info", post(api::user::change_user_info))
        .route("/api/get_teacher_list", post(api::info::get_teacher_list))
        .route("/api/get_reason_list", get(api::info::get_reason_list))
        .route("/api/add_reason_list", post(api::info::add_reason_list))
        .route("/api/delete_reason_list", post(api::info::delete_reason_list))
        .layer(TraceLayer::new_for_http())
        .with_state(pool);

    let listener = tokio::net::TcpListener::bind("127.0.0.1:3000")
        .await
        .unwrap();
    info!("server listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.unwrap();
}

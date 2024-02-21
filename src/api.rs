use axum::{http::StatusCode, response::IntoResponse, Json};
use serde_json::json;

use self::jwt::AuthError;

mod jwt;
pub mod user;
pub mod info;
pub mod message;
pub mod chouxiang;

pub enum ApiError {
    LoginError,
    InvalidParameter,
    PermissionDenied,
    DatabaseError(String),
    Auth(AuthError),
    Internal(anyhow::Error),
}

impl<E> From<E> for ApiError
where
    E: Into<anyhow::Error>,
{
    fn from(err: E) -> ApiError {
        ApiError::Internal(err.into())
    }
}

impl From<AuthError> for ApiError {
    fn from(err: AuthError) -> Self {
        ApiError::Auth(err.into())
    }
}

impl IntoResponse for ApiError {
    fn into_response(self) -> axum::response::Response {
        match self {
            ApiError::Auth(err) => err.into_response(),
            ApiError::Internal(err) => {
                let body = Json(json!({
                    "error": err.to_string(),
                }));
                (StatusCode::INTERNAL_SERVER_ERROR, body).into_response()
            },
            ApiError::LoginError => {
                let body = Json(json!({
                    "error": "Invalid username or password",
                }));
                (StatusCode::UNAUTHORIZED, body).into_response()
            }
            ApiError::InvalidParameter => {
                let body = Json(json!({
                    "error": "Invalid parameter",
                }));
                (StatusCode::BAD_REQUEST, body).into_response()
            }
            ApiError::PermissionDenied => {
                let body: Json<serde_json::Value> = Json(json!({
                    "error": "Permission denied",
                }));
                (StatusCode::FORBIDDEN, body).into_response()
            }
            ApiError::DatabaseError(err) => {
                let body = Json(json!({
                    "error": err,
                }));
                (StatusCode::BAD_REQUEST, body).into_response()
            }
        }
    }
}

pub fn image_encode(image_data: &Vec<u8>, default_image: String) -> String {
    #[allow(deprecated)]
    if image_data.is_empty() {
        default_image
    } else {
        base64::encode(&image_data)
    }
}

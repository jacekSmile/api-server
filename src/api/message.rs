use axum::{extract::State, Json};
use sqlx::{Pool, Sqlite};
use serde::{Deserialize, Serialize};

use crate::db::{Message, User};

use super::{jwt::Uid, ApiError};


#[derive(Deserialize)]
pub struct SendPlayload {
    pub target: i32,
    pub content: String,
}

pub async fn send_message(
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
    Json(payload): Json<SendPlayload>,
) -> Result<(), ApiError> {
    let result = sqlx::query("insert into messages (from_user_id, to_user_id, content) values (?, ?, ?);")
        .bind(&user_id)
        .bind(&payload.target)
        .bind(&payload.content)
        .execute(&pool)
        .await;

    match result {
        Ok(_) => Ok(()),
        Err(_) => Err(ApiError::InvalidParameter),
    }
}

#[derive(Serialize)]
pub struct MessageResponse {
    pub from_user_name: String,
    pub to_user_name: String,
    pub content: String,
    pub created_at: String,
}

pub async fn get_user_name(user_id: i32, State(pool): State<Pool<Sqlite>>) -> Result<String, ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?;")
        .bind(&user_id)
        .fetch_one(&pool)
        .await;

    match user {
        Ok(user) => Ok(user.name),
        Err(_) => Err(ApiError::Internal(anyhow::anyhow!("No user found."))),
    }
}

pub async fn get_messages (
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
) -> Result<Json<Vec<MessageResponse>>, ApiError> {
    let messages = sqlx::query_as::<_, Message>("select * from messages where to_user_id = ? or from_user_id = ? order by created_at desc;")
        .bind(&user_id)
        .bind(&user_id)
        .fetch_all(&pool)
        .await;

    let messages: Vec<MessageResponse> = match messages {
        Ok(messages) => {
            let mut messages_with_name: Vec<MessageResponse> = Vec::new();
            for message in messages {
                messages_with_name.push(MessageResponse {
                    from_user_name: get_user_name(message.from_user_id, State(pool.clone())).await?,
                    to_user_name: get_user_name(message.to_user_id, State(pool.clone())).await?,
                    content: message.content,
                    created_at: message.created_at,
                });
            }
            messages_with_name
        }
        Err(_) => return Err(ApiError::Internal(anyhow::anyhow!("No messages found."))),
    };

    Ok(Json(messages))
}

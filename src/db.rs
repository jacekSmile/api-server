use std::env;
use sqlx::{Pool, Sqlite, SqlitePool};

pub async fn establish_connection() -> Pool<Sqlite> {
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let pool = SqlitePool::connect(&database_url)
        .await
        .expect("Failed to connect to database");
    pool
}

#[derive(sqlx::FromRow)]
pub struct User {
    pub id: i32,
    pub name: String,
    pub account: String,
    pub password: String,
    pub type_info: i32,
    pub information: String,
    pub image: Vec<u8>,
}

#[derive(sqlx::FromRow, serde::Serialize)]
pub struct Reason {
    pub id: i32,
    pub user_id: i32,
    pub content: String,
}

#[derive(sqlx::FromRow, serde::Serialize)]
pub struct Advise {
    pub id: i32,
    pub title: String,
    pub content: String,
    pub isanonymous: bool,
    pub user_id: i32,
    pub created_at: String,
}

#[derive(sqlx::FromRow, serde::Serialize)]
pub struct Message {
    pub from_user_id: i32,
    pub to_user_id: i32,
    pub content: String,
    pub created_at: String,
}

#[derive(sqlx::FromRow, serde::Serialize)]
pub struct Match {
    pub id: i32,
    pub student_id: i32,
    pub teacher_id: i32,
    pub teacher_reason: String,
    pub admin_reason: String,
    pub teacher_sign_info: Vec<u8>,
    pub student_sign_info: Vec<u8>,
    pub table_info: String,
    pub status_info: i32,
    pub turn_id: i32,
}

#[derive(sqlx::FromRow, serde::Serialize)]
pub struct Turn {
    pub id: i32,
    pub start_datetime: String,
    pub end_datetime: String,
    pub turn_id: i32,
}

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
pub struct Teacher {
    pub id: i32,
    pub name: String,
    pub department: String,
    pub office: String,
    pub phone_number: String,
    pub email: String,
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
}

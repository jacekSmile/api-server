use axum::{extract::State, Json};
use sqlx::{Pool, Sqlite};
use serde::{Deserialize, Serialize};

use crate::db::{Reason, Teacher, User};

use super::{jwt::Uid, ApiError};

#[derive(Deserialize)]
pub struct ListPayload {
    pub start: i32,
    pub end: i32,
}

#[derive(Deserialize)]
pub struct AddReasonPayload {
    pub content: String,
}

#[derive(Serialize)]
pub struct TeacherList {
    pub teachers: Vec<Teacher>,
    pub total: i32,
}

impl TeacherList {
    pub fn new(teachers: Vec<Teacher>, total: i32) -> Self {
        Self {
            teachers,
            total,
        }
    }
}

#[derive(Serialize)]
pub struct ReasonList {
    pub reasons: Vec<Reason>,
    pub total: i32,
}

impl ReasonList {
    pub fn new(reasons: Vec<Reason>, total: i32) -> Self {
        Self {
            reasons,
            total,
        }
    }
}

pub async fn get_teacher_list(
    State(pool): State<Pool<Sqlite>>,
    Json(payload): Json<ListPayload>
) -> Result<Json<TeacherList>, ApiError> {
    if payload.start > payload.end {
        return Err(ApiError::InvalidParameter);
    }

    let total = sqlx::query_scalar("select count(*) from teachers;")
        .fetch_one(&pool)
        .await?;

    let teachers = sqlx::query_as::<_, Teacher>("select * from teachers where id between ? and ?;")
        .bind(&payload.start)
        .bind(&payload.end)
        .fetch_all(&pool)
        .await?;

    Ok(Json(TeacherList::new(teachers, total)))
}

pub async fn get_reason_list(
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
) -> Result<Json<ReasonList>, ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info == 0 {
        return Err(ApiError::PermissionDenied);
    }

    let total = sqlx::query_scalar("select count(*) from reasons where user_id = ?;")
        .bind(&user_id)
        .fetch_one(&pool)
        .await?;

    let reasons = sqlx::query_as::<_, Reason>("select * from reasons where user_id = ?;")
        .bind(&user_id)
        .fetch_all(&pool)
        .await?;
    
    Ok(Json(ReasonList::new(reasons, total)))
}

pub async fn add_reason_list(
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
    Json(payload): Json<AddReasonPayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info == 0 {
        return Err(ApiError::PermissionDenied);
    }

    let res = sqlx::query("insert into reasons (user_id, content) values (?, ?);")
        .bind(&user_id)
        .bind(&payload.content)
        .execute(&pool)
        .await;

    match res {
        Ok(_) => Ok(()),
        Err(_) => {
            Err(ApiError::DatabaseError(String::from("Cannot insert duplicates")))
        }
    }
}

pub async fn delete_reason_list(
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
    Json(payload): Json<AddReasonPayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info == 0 {
        return Err(ApiError::PermissionDenied);
    }

    sqlx::query("delete from reasons where user_id = ? and content = ?;")
        .bind(&user_id)
        .bind(&payload.content)
        .execute(&pool)
        .await?;

    Ok(())
}

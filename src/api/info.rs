use axum::{extract::State, Json};
use chrono::NaiveTime;
use sqlx::{Pool, Sqlite};
use serde::{Deserialize, Serialize};

use crate::db::{Advise, Reason, User};

use super::{jwt::Uid, user::TeacherInfo, ApiError};

#[derive(Deserialize)]
pub struct ListPayload {
    pub start: i32,
    pub end: i32,
}

#[derive(Deserialize)]
pub struct ReasonPayload {
    pub content: String,
}

#[derive(Deserialize)]
pub struct AddAdvisePayload {
    pub title: String,
    pub content: String,
    pub isanonymous: bool,
}

#[derive(Serialize)]
pub struct TeacherList {
    pub teachers: Vec<TeacherInfo>,
    pub total: i32,
}

impl TeacherList {
    pub fn new(teachers: Vec<TeacherInfo>, total: i32) -> Self {
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

    let total = sqlx::query_scalar("select count(*) from users where type_info = 1;")
        .fetch_one(&pool)
        .await?;

    let teacher_users = sqlx::query_as::<_, User>("select * from users where type_info = 1 limit ? offset ?;")
        .bind(&payload.end - &payload.start + 1)
        .bind(&payload.start)
        .fetch_all(&pool)
        .await?;

    Ok(Json(TeacherList::new(
        teacher_users.into_iter().map(|user| {
            let mut teacher: TeacherInfo = serde_json::from_str(&user.information).unwrap();
            teacher.user_id = user.id;
            teacher
        }).collect()
        , total
    )))
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
    Json(payload): Json<ReasonPayload>,
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
    Json(payload): Json<ReasonPayload>,
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

pub async fn send_suggestion (
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
    Json(payload): Json<AddAdvisePayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info != 0 {
        return Err(ApiError::PermissionDenied);
    }

    sqlx::query("insert into advises (title, content, isanonymous, user_id) values (?, ?, ?, ?);")
        .bind(&payload.title)
        .bind(&payload.content)
        .bind(&payload.isanonymous)
        .bind(&user_id)
        .execute(&pool)
        .await?;

    Ok(())
}

#[derive(Serialize)]
pub struct SuggestionDetail {
    pub who: String,
    pub title: String,
    pub content: String,
    pub created_at: String,
}

pub async fn get_suggestions (
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
) -> Result<Json<Vec<SuggestionDetail>>, ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info != 2 {
        return Err(ApiError::PermissionDenied);
    }

    let suggestions = sqlx::query_as::<_, Advise>("select * from advises")
        .fetch_all(&pool)
        .await?;

    let mut suggestion_details = Vec::new();
    for suggestion in suggestions {
        suggestion_details.push(SuggestionDetail {
            who: if suggestion.isanonymous {
                String::from("匿名")
            } else {
                sqlx::query_as::<_, User>("select * from users where id = ?")
                    .bind(&suggestion.user_id)
                    .fetch_one(&pool)
                    .await
                    .map_err(ApiError::from)?
                    .name
            },
            title: suggestion.title,
            content: suggestion.content,
            created_at: suggestion.created_at,
        });
    }

    Ok(Json(suggestion_details))
}

fn is_in_time_duration(time_duration: &str) -> bool {
    let now_time = chrono::Local::now();
    let now_time = now_time.time();
    let time_duration = time_duration.split(",").collect::<Vec<&str>>();
    for time in time_duration {
        let time = time.split("-").collect::<Vec<&str>>();
        let start_time = NaiveTime::parse_from_str(time[0], "%H:%M:%S")
            .expect("Failed to parse start time");
        let end_time = NaiveTime::parse_from_str(time[1], "%H:%M:%S")
            .expect("Failed to parse end time");
        if now_time >= start_time && now_time <= end_time {
            return true;
        }
    }
    false
}

pub async fn get_valid_teacher(
    State(pool): State<Pool<Sqlite>>,
) -> Result<Json<Vec<TeacherInfo>>, ApiError> {
    let teachers = sqlx::query_as::<_, User>("select * from users where type_info = 1;")
        .fetch_all(&pool)
        .await?;

    let vaild_teachers: Vec<TeacherInfo> = teachers.into_iter().map(
        |user| {
        let mut teacher: TeacherInfo = serde_json::from_str(&user.information).unwrap();
        teacher.user_id = user.id;
        teacher
    }).filter(|teacher| is_in_time_duration(&teacher.time_duration)).collect();

    Ok(Json(vaild_teachers))
}

#[derive(Serialize)]
pub struct BaseUserInfo {
    pub user_id: i32,
    pub username: String,
    pub type_info: i32,
}

pub async fn get_user_list(
    State(pool): State<Pool<Sqlite>>,
) -> Result<Json<Vec<BaseUserInfo>>, ApiError> {
    let user_infos = sqlx::query_as::<_, User>("select * from users;")
        .fetch_all(&pool)
        .await?;

    Ok(Json(user_infos.into_iter().map(|user: User| {
        BaseUserInfo {
            user_id: user.id,
            username: user.name,
            type_info: user.type_info,
        }
    }).collect()))
}

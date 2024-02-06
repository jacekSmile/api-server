use std::env;

use axum::{extract::State, Json};
use axum::extract::Multipart;
use jsonwebtoken::{encode, EncodingKey, Header};
use serde_json::Value;
use sqlx::{Pool, Sqlite};
use serde::{Deserialize, Serialize};
use base64;

use crate::db::User;

use super::{jwt::{AuthError, Claims, Uid}, ApiError};

#[derive(Deserialize)]
pub struct LoginPayload {
    username: String,
    password: String,
}

#[derive(Serialize)]
pub struct AuthBody {
    access_token: String,
    token_type: String,
    user_type: i32,
}

// User_info 记录用户信息
// 里面有 Student_info, Teacher_info, Admin_info
#[derive(Serialize, Deserialize)]
pub enum UserInfo {
    Student(StudentInfo),
    Teacher(TeacherInfo),
    Admin(AdminInfo),
}

#[derive(Serialize, Deserialize)]
pub struct StudentInfo {
    student_id: String,
    name: String,
    class_room: String,
    phone_number: String,
    political_status: String,
    email: String,
    home_address: String,
    interesting: String,
    employment_intention: String,
    honors: String,
    image: String,
}

#[derive(Serialize, Deserialize)]
pub struct TeacherInfo {
    name: String,
}

#[derive(Serialize, Deserialize)]
pub struct AdminInfo {
    name: String,
}

impl StudentInfo {
    fn new(json_data: &String, image: &String, student_id: &String) -> Self {
        let mut value: Result<Value, _> = serde_json::from_str(json_data);

        if let Ok(obj) = value.as_mut() {
            obj.as_object_mut()
                .unwrap()
                .insert("image".to_string(), Value::String(image.clone()));

            obj.as_object_mut()
                .unwrap()
                .insert("student_id".to_string(), Value::String(student_id.clone()));
        }

        serde_json::from_str(&value.unwrap().to_string()).unwrap()
    }
}

impl TeacherInfo {
    fn new(json_data: &String, image: &String) -> Self {
        let mut value: Result<Value, _> = serde_json::from_str(json_data);

        if let Ok(obj) = value.as_mut() {
            obj.as_object_mut()
                .unwrap()
                .insert("image".to_string(), Value::String(image.clone()));
        }

        serde_json::from_str(&value.unwrap().to_string()).unwrap()
    }
}

impl AdminInfo {
    fn new(json_data: &String, image: &String) -> Self {
        let mut value: Result<Value, _> = serde_json::from_str(json_data);

        if let Ok(obj) = value.as_mut() {
            obj.as_object_mut()
                .unwrap()
                .insert("image".to_string(), Value::String(image.clone()));
        }

        serde_json::from_str(&value.unwrap().to_string()).unwrap()
    }
}

impl AuthBody {
    fn new (access_token: String, user_type: i32) -> Self {
        Self {
            access_token,
            token_type: "Bearer".to_string(),
            user_type,
        }
    }
}

pub async fn login(
    State(pool): State<Pool<Sqlite>>,
    Json(payload): Json<LoginPayload>,
) -> Result<Json<AuthBody>, ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where account = ? and password = ?")
        .bind(&payload.username)
        .bind(&payload.password)
        .fetch_one(&pool)
        .await;

    let user: User = match user {
        Ok(user) => user,
        Err(sqlx::Error::RowNotFound) => {
            return Err(ApiError::LoginError); // Pass an error message to the `ApiError::from()` function.
        },
        Err(e) => return Err(ApiError::from(e)),
    };

    let claims = Claims::new(user.id.to_string());
    let token = encode(
        &Header::default(),
        &claims,
        &EncodingKey::from_secret(b"secret")
    )
    .map_err(|_| AuthError::TokenCreation)?;

    Ok(Json(AuthBody::new(token, user.type_info)))
}

pub async fn get_user_info(
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
) -> Result<Json<UserInfo>, ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;
    
    #[allow(deprecated)]
    let image = if user.image.is_empty() {
        env::var("DEFAULT_IMAGE_DATA").expect("DEFAULT_IMAGE_DATA must be set")
    } else {
        base64::encode(&user.image)
    };

    match user.type_info {
        0 => {
            Ok(Json(UserInfo::Student(StudentInfo::new(&user.information, &image, &user.account))))
        },
        1 => {
            Ok(Json(UserInfo::Teacher(TeacherInfo::new(&user.information, &image))))
        },
        2 => {
            Ok(Json(UserInfo::Admin(AdminInfo::new(&user.information, &image))))
        },
        _ => Err(ApiError::Internal(anyhow::anyhow!("Unknown user type"))),
    }
}

#[derive(Serialize, Deserialize)]
pub struct UpdateStudentInfoPayload {
    pub name: String,
    pub class_room: String,
    pub phone_number: String,
    pub political_status: String,
    pub email: String,
    pub home_address: String,
    pub interesting: String,
    pub employment_intention: String,
}

#[derive(Serialize, Deserialize)]
pub struct UpdateTeacherInfoPayload {
    pub name: String,
}

#[derive(Serialize, Deserialize)]
pub struct UpdateAdminInfoPayload {
    pub name: String,
}

pub async fn change_user_info(
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
    Json(payload): Json<Value>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    let update_json_data: String = match user.type_info {
        0 => {
            let update_json_data: UpdateStudentInfoPayload = serde_json::from_value(payload).unwrap();
            serde_json::to_string(&update_json_data).unwrap()
        },
        1 => {
            let update_json_data: UpdateTeacherInfoPayload = serde_json::from_value(payload).unwrap();
            serde_json::to_string(&update_json_data).unwrap()
        }
        2 => {
            let update_json_data: UpdateAdminInfoPayload = serde_json::from_value(payload).unwrap();
            serde_json::to_string(&update_json_data).unwrap()
        },
        _ => {
            return Err(ApiError::Internal(anyhow::anyhow!("Unknown user type")));
        }
    };

    sqlx::query("update users set information = ? where id = ?")
        .bind(&update_json_data)
        .bind(&user_id)
        .execute(&pool)
        .await?;

    Ok(())
}

#[derive(Deserialize)]
pub struct ChangePasswordPayload {
    old_password: String,
    new_password: String,
}

pub async fn change_password(
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
    Json(payload): Json<ChangePasswordPayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.password != payload.old_password {
        return Err(ApiError::PermissionDenied);
    } else {
        sqlx::query("update users set password = ? where id = ?")
            .bind(&payload.new_password)
            .bind(&user_id)
            .execute(&pool)
            .await?;
    }

    Ok(())
}

pub async fn change_img(
    Uid(user_id): Uid,
    State(pool): State<Pool<Sqlite>>,
    mut multipart: Multipart,
) -> Result<(), ApiError> {
    
    while let Some(mut field) = multipart.next_field()
        .await? {
            while let Some(chunk) = field.chunk().await? {
                sqlx::query("update users set image = ? where id = ?")
                    .bind(&chunk.to_vec())
                    .bind(&user_id)
                    .fetch_one(&pool)
                    .await
                    .map_err(ApiError::from)?;
            }
        }

    Ok(())
}

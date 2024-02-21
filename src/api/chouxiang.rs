use std::collections::HashMap;
use std::env;

use axum::{extract::{Multipart, State}, Json};
use chrono::NaiveDateTime;
use sqlx::{Pool, Sqlite};
use serde::{Deserialize, Serialize};

use crate::db::{Match, Turn, User};

use super::{jwt::Uid, user::{AdminInfo, StudentInfo, TeacherInfo, UserInfo}, ApiError};

pub async fn get_current_turn (
    pool: &Pool<Sqlite>,
) -> Result<Turn, ApiError> {
    let now_time = chrono::Local::now();
    let now_time = NaiveDateTime::parse_from_str(&now_time.format("%Y-%m-%d %H:%M:%S").to_string(), "%Y-%m-%d %H:%M:%S")
        .expect("Failed to parse now time");

    let turns_info = sqlx::query_as::<_, Turn>("select * from turn")
        .fetch_all(pool)
        .await
        .map_err(ApiError::from)?;

    for turn_info in turns_info {
        let start_time = NaiveDateTime::parse_from_str(&turn_info.start_datetime, "%Y-%m-%d %H:%M:%S")
            .expect("Failed to parse start time");

        let end_time = NaiveDateTime::parse_from_str(&turn_info.end_datetime, "%Y-%m-%d %H:%M:%S")
            .expect("Failed to parse end time");

        if now_time >= start_time && now_time <= end_time {
            return Ok(turn_info);
        }
    }

    // 如果在时间之外要特殊判断
    let first_turn_info = sqlx::query_as::<_, Turn>("select * from turn where turn_id = 1")
        .fetch_one(pool)
        .await
        .map_err(ApiError::from)?;

    let first_end_datetime = NaiveDateTime::parse_from_str(&first_turn_info.end_datetime, "%Y-%m-%d %H:%M:%S")
        .expect("Failed to parse end time");

    let second_turn_info = sqlx::query_as::<_, Turn>("select * from turn where turn_id = 2")
        .fetch_one(pool)
        .await
        .map_err(ApiError::from)?;

    let second_start_datetime = NaiveDateTime::parse_from_str(&second_turn_info.start_datetime, "%Y-%m-%d %H:%M:%S")
        .expect("Failed to parse start time");

    let second_end_datetime = NaiveDateTime::parse_from_str(&second_turn_info.end_datetime, "%Y-%m-%d %H:%M:%S")
        .expect("Failed to parse end time");

    return if now_time < first_end_datetime {
        Ok(first_turn_info)
    } else if now_time < second_start_datetime {
        Ok(second_turn_info)
    } else if now_time < second_end_datetime {
        Ok(second_turn_info)
    } else {
        Ok(first_turn_info)
    }
}

#[derive(Deserialize)]
pub struct SendTeacherIdPayload {
    pub teacher_id: i32,
}

pub async fn send_student_info (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    Json(payload): Json<SendTeacherIdPayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info != 0 {
        return Err(ApiError::PermissionDenied);
    }

    let result = sqlx::query("insert into matchs (student_id, teacher_id, status_info, turn_id) values (?, ?, 0, ?)")
        .bind(user_id)
        .bind(payload.teacher_id)
        .bind(get_current_turn(&pool).await?.turn_id)
        .execute(&pool)
        .await?;

    match result.rows_affected() {
        1 => Ok(()),
        _ => Err(ApiError::Internal(anyhow::anyhow!("Failed to send student info"))),
    }
}

#[derive(Deserialize)]
pub struct SendStudentIdPayload {
    pub selection_id: i32,
}

pub async fn get_student_info (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    Json(payload): Json<SendStudentIdPayload>,
) -> Result<Json<UserInfo>, ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info != 1 {
        return Err(ApiError::PermissionDenied);
    }

    let match_record = sqlx::query_as::<_, Match>("select * from matchs where teacher_id = ? and student_id = ?")
        .bind(&user_id)
        .bind(payload.selection_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from);

    match match_record {
        Ok(match_record) => {
            let student_info = sqlx::query_as::<_, User>("select * from users where id = ?")
                .bind(match_record.student_id)
                .fetch_one(&pool)
                .await
                .map_err(ApiError::from)?;

            #[allow(deprecated)]
            let image = if user.image.is_empty() {
                env::var("DEFAULT_IMAGE_DATA").expect("DEFAULT_IMAGE_DATA must be set")
            } else {
                base64::encode(&user.image)
            };

            Ok(Json(UserInfo::Student(StudentInfo::new(&student_info.information, &image, &student_info.account))))
        },
        Err(_) => {
            Err(ApiError::PermissionDenied)
        }
    }
}

pub async fn send_sign (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    mut multipart: Multipart,
) -> Result<(), ApiError> {
    let mut image_data = Vec::new();
    
    while let Some(mut field) = multipart.next_field()
        .await? {
            while let Some(chunk) = field.chunk().await? {
                image_data.extend_from_slice(&chunk);
            }
        }

    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    match user.type_info {
        0 => {
            sqlx::query("update matchs set student_sign_info = ? where student_id = ?")
                .bind(image_data)
                .bind(user_id)
                .execute(&pool)
                .await?;
        }
        1 => {
            sqlx::query("update matchs set teacher_sign_info = ? where teacher_id = ?")
                .bind(image_data)
                .bind(user_id)
                .execute(&pool)
                .await?;
        }
        _ => {
            return Err(ApiError::PermissionDenied);
        }
    }
    
    Ok(())
}

#[derive(Deserialize)]
pub struct SendSelectionIdPayload {
    pub selection_id: i32,
}

#[derive(Serialize)]
pub struct SignInfoResponse {
    #[serde(rename = "teachersign")]
    pub teacher_sign: String,
    #[serde(rename = "studentsign")]
    pub student_sign: String,
}

pub async fn get_sign (
    State(pool): State<Pool<Sqlite>>,
    // Uid(user_id): Uid,
    Json(payload): Json<SendSelectionIdPayload>,
) -> Result<Json<SignInfoResponse>, ApiError> {
    let match_record = sqlx::query_as::<_, Match>("select * from matchs where id = ?")
        .bind(payload.selection_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;
    
    Ok(Json(SignInfoResponse{
        #[allow(deprecated)]
        teacher_sign: base64::encode(&match_record.teacher_sign_info),
        #[allow(deprecated)]
        student_sign: base64::encode(&match_record.student_sign_info),
    }))
}

#[derive(Deserialize)]
pub struct ExamSelectionPayload {
    pub reason: String,
    #[serde(rename = "ispass")]
    pub is_pass: bool,
    #[serde(rename = "selection_id")]
    pub selection_ids: Vec<i32>,
}

pub async fn exam_selection (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    Json(payload): Json<ExamSelectionPayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    let pass_status: i32;
    let fail_status: i32;

    match user.type_info {
        1 => {
            pass_status = 1;
            fail_status = 2;
        }
        2 => {
            pass_status = 3;
            fail_status = 4;
        }
        _ => {
            return Err(ApiError::PermissionDenied);
        }
    }

    let user_type = if user.type_info == 1 {"teacher"} else {"admin"};
    let sql_payload = format!("update matchs set {}_reason = ?, status_info = ? where id = ?", user_type);

    for selection_id in &payload.selection_ids {
        let match_record = sqlx::query_as::<_, Match>("select * from matchs where id = ?")
            .bind(selection_id)
            .fetch_one(&pool)
            .await
            .map_err(ApiError::from)?;

        sqlx::query(&sql_payload)
            .bind(&payload.reason)
            .bind(if payload.is_pass {pass_status} else {fail_status})
            .bind(selection_id)
            .execute(&pool)
            .await?;

        if !payload.is_pass {
            sqlx::query("insert into messages (from_user_id, to_user_id, content) values (?, ?, ?);")
                .bind(&user_id)
                .bind(&match_record.student_id)
                .bind(format!("你的申请被{}驳回，理由是{}", user_type, &payload.reason))
                .execute(&pool)
                .await?;
        }
    }
    
    Ok(())
}

#[derive(Deserialize)]
pub struct SetExamTimePayload {
    pub start_time: String,
    pub end_time: String,
}

pub async fn set_exam_time (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    Json(payload): Json<SetExamTimePayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    let user_info: String = match user.type_info {
        1 => {
            let mut teacher_info: TeacherInfo = serde_json::from_str(&user.information).unwrap();
            teacher_info.time_duration = payload.start_time.clone() + "-" + &payload.end_time;
            serde_json::to_string(&teacher_info).unwrap()
        }
        2 => {
            let mut admin_info: AdminInfo = serde_json::from_str(&user.information).unwrap();
            admin_info.time_duration = payload.start_time.clone() + "-" + &payload.end_time;
            serde_json::to_string(&admin_info).unwrap()
        }
        _ => {
            return Err(ApiError::PermissionDenied);
        }
    };

    sqlx::query("update users set information = ? where id = ?")
        .bind(&user_info)
        .bind(user_id)
        .execute(&pool)
        .await?;
    
    Ok(())
}

#[derive(Deserialize)]
pub struct SetTimePayload {
    pub start_datetime: String,
    pub end_datetime: String,
    pub turn: i32,
}

pub async fn set_start_end_date (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    Json(payloads): Json<Vec<SetTimePayload>>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info != 2 {
        return Err(ApiError::PermissionDenied);
    }

    for payload in payloads {
        sqlx::query("update turn set start_datetime = ?, end_datetime = ? where turn_id = ?")
            .bind(&payload.start_datetime)
            .bind(&payload.end_datetime)
            .bind(&payload.turn)
            .execute(&pool)
            .await?;
    }
    
    Ok(())
}

pub async fn withdraw (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    Json(payload): Json<SendSelectionIdPayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    match user.type_info {
        1 => {
            sqlx::query("update matchs set status_info = 0 where id = ?")
                .bind(&payload.selection_id)
                .execute(&pool)
                .await?;
            Ok(())
        }
        2 => {
            sqlx::query("update matchs set status_info = 3 where id = ?")
                .bind(&payload.selection_id)
                .execute(&pool)
                .await?;
            Ok(())
        }
        _ => {
            Err(ApiError::PermissionDenied)
        }
    }
}

#[derive(Serialize, Debug)]
pub struct SingleSelectionInfoWithName {
    pub turns: i32,
    pub status: i32,
    pub student_name: String,
    pub teacher_name: String,
    pub selection_id: i32,
}

#[derive(Serialize)]
pub struct SelectionInfo {
    pub selections: Vec<SingleSelectionInfoWithName>,
    pub start_time: String,
    pub end_time: String,
    pub turns: i32,
}

pub async fn get_select (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
) -> Result<Json<SelectionInfo>, ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    let match_records: Vec<Match> = match user.type_info {
        0 => {
            sqlx::query_as::<_, Match>("select * from matchs where student_id = ?")
                .bind(&user_id)
                .fetch_all(&pool)
                .await
                .unwrap_or_else(|_| Vec::new())
        }
        1 => {
            sqlx::query_as::<_, Match>("select * from matchs where teacher_id = ?")
                .bind(&user_id)
                .fetch_all(&pool)
                .await
                .unwrap_or_else(|_| Vec::new())
        }
        2 => {
            sqlx::query_as::<_, Match>("select * from matchs where status_info >= 3")
                .fetch_all(&pool)
                .await
                .unwrap_or_else(|_| Vec::new())
        }
        _ => {
            return Err(ApiError::PermissionDenied)
        }
    };

    let mut selections = Vec::new();

    for match_record in match_records {

        let single_selection = SingleSelectionInfoWithName {
            turns: match_record.turn_id,
            status: match_record.status_info,
            student_name: sqlx::query_as::<_, User>("select * from users where id = ?")
                .bind(&match_record.student_id)
                .fetch_one(&pool)
                .await
                .map_err(ApiError::from)?
                .name,
            teacher_name: sqlx::query_as::<_, User>("select * from users where id = ?")
                .bind(&match_record.teacher_id)
                .fetch_one(&pool)
                .await
                .map_err(ApiError::from)?
                .name,
            selection_id: match_record.id,
        };
        selections.push(single_selection);
    }

    let turn = get_current_turn(&pool).await?;

    Ok(Json(SelectionInfo {
        selections,
        start_time: turn.start_datetime,
        end_time: turn.end_datetime,
        turns: turn.turn_id,
    }))
}

#[derive(Deserialize, Serialize)]
pub struct SendTwoWayTablePayload {
    pub teacher_name: String,
    pub score: f64,
    pub rank: i32,
    pub phone_number: String,
    pub position: String,
    pub math_score1: i32,
    pub math_score2: i32,
    pub c_score1: i32,
    pub c_score2: i32,
    pub self_introduce: String,
    pub isok: bool,
    pub selection_id: i32,
}

#[derive(Serialize, Deserialize)]
pub struct GetTwoWayTableResponse {
    pub student_name: String,
    pub student_id: String,
    pub rank: i32,
    pub teacher_name: String,
    pub score: f64,
    pub phone_number: String,
    pub position: String,
    pub math_score1: i32,
    pub math_score2: i32,
    pub c_score1: i32,
    pub c_score2: i32,
    pub self_introduce: String,
    pub isok: bool,
    pub selection_id: i32,
}

pub async fn send_two_way_table (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    Json(payload): Json<SendTwoWayTablePayload>,
) -> Result<(), ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info != 0 {
        return Err(ApiError::PermissionDenied);
    }

    let result = sqlx::query("update matchs set table_info = ?, status_info = 3 where id = ?")
        .bind(serde_json::to_string(&payload).unwrap())
        .bind(payload.selection_id)
        .execute(&pool)
        .await?;

    match result.rows_affected() {
        1 => Ok(()),
        _ => Err(ApiError::Internal(anyhow::anyhow!("Failed to send two table info"))),
    }
}

pub async fn get_two_way_table (
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
    Json(payload): Json<SendSelectionIdPayload>,
) -> Result<Json<GetTwoWayTableResponse>, ApiError> {
    let user = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    if user.type_info != 2 {
        return Err(ApiError::PermissionDenied);
    }

    let match_record = sqlx::query_as::<_, Match>("select * from matchs where id = ?")
        .bind(payload.selection_id)
        .fetch_one(&pool)
        .await
        .map_err(ApiError::from)?;

    let two_way_table_info: SendTwoWayTablePayload = serde_json::from_str(&match_record.table_info)
        .map_err(ApiError::from)?;

    let two_way_table_info = {
        GetTwoWayTableResponse {
            student_name: sqlx::query_as::<_, User>("select * from users where id = ?")
                .bind(&match_record.student_id)
                .fetch_one(&pool)
                .await
                .map_err(ApiError::from)?
                .name,
            student_id: sqlx::query_as::<_, User>("select * from users where id = ?")
                .bind(&match_record.student_id)
                .fetch_one(&pool)
                .await
                .map_err(ApiError::from)?
                .account,
            rank: two_way_table_info.rank,
            teacher_name: two_way_table_info.teacher_name,
            score: two_way_table_info.score,
            phone_number: two_way_table_info.phone_number,
            position: two_way_table_info.position,
            math_score1: two_way_table_info.math_score1,
            math_score2: two_way_table_info.math_score2,
            c_score1: two_way_table_info.c_score1,
            c_score2: two_way_table_info.c_score2,
            self_introduce: two_way_table_info.self_introduce,
            isok: two_way_table_info.isok,
            selection_id: payload.selection_id,
        }
    };

    Ok(Json(two_way_table_info))
}

pub async fn start_second(
    State(pool): State<Pool<Sqlite>>,
    Uid(user_id): Uid,
) -> Result<(), ApiError> {
    let users = sqlx::query_as::<_, User>("select * from users where id = ?")
        .bind(&user_id)
        .fetch_all(&pool)
        .await
        .map_err(ApiError::from)?;

    let mut un_matched_student_user_ids = Vec::new();
    let mut teacher_count = HashMap::new();

    for user in users {
        match user.type_info {
            0 => {
                un_matched_student_user_ids.push(user.id);
            }
            1 => {
                let teacher_totals: i32 = sqlx::query_scalar("select count(*) from matchs where teacher_id = ? and status_info = 4")
                    .bind(&user.id)
                    .fetch_one(&pool)
                    .await
                    .map_err(ApiError::from)?;

                teacher_count.insert(user.id, teacher_totals);
            }
            _ => {}
        }
    }

    for un_matched_student_user_id in un_matched_student_user_ids {
        for (teacher_id, total) in &teacher_count {
            if *total < 6 {
                sqlx::query("insert into matchs (student_id, teacher_id, status_info, turn_id) values (?, ?, 4, ?) ")
                    .bind(un_matched_student_user_id)
                    .bind(teacher_id)
                    .bind(get_current_turn(&pool).await?.turn_id)
                    .execute(&pool)
                    .await?;
            }
        }
    }

    Ok(())
}

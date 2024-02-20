create table matchs (
    id integer primary key not null,
    student_id integer not null,
    teacher_id integer not null,
    table_info text,
    teacher_reason text,
    admin_reason text,
    teacher_sign_info blob,
    student_sign_info blob,
    status_info integer not null,
    turn_id integer not null,
);

create index matchs_id_index on matchs (id);

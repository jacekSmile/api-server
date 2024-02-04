create table reasons (
    id integer primary key not null,
    user_id integer not null,
    content text not null
);

create index reasons_user_id_index on reasons (user_id);

create unique index reasons_content_index on reasons (content);

-- 测试数据
insert into reasons (user_id, content) values (
    2,
    '不好意，你不适合'
);

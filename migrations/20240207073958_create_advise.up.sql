create table advise (
    id integer primary key not null,
    title text not null,
    content text not null,
    isanonymous boolean not null,
    user_id integer not null,
);

create index advise_id_index on advise (id);

-- 测试数据
insert into advise (title, content, isanonymous, user_id) values (
    '不好意，你不适合',
    '不好意，你不适合',
    false,
    2
);

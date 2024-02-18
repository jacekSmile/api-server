create table advises (
    id integer primary key not null,
    title text not null,
    content text not null,
    isanonymous boolean not null,
    user_id integer not null
);

create index advises_id_index on advises (id);

-- 测试数据
insert into advises (title, content, isanonymous, user_id) values (
    '不好意，你不适合',
    '不好意，你不适合',
    false,
    2
);

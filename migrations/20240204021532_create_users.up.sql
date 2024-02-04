create table users (
    id integer primary key not null,
    name text not null,
    account text not null,
    password text not null,
    type_info integer not null,
    information text not null,
    image blob
);

create unique index users_account_index on users (account);

-- 测试数据
insert into users (name, account, password, type_info, information, image) values (
    '杨楚洁',
    '202203150323',
    '123456',
    0,
    '{"name": "杨楚洁", "class_room": "软外2202班", "phone_number": "19856655987", "political_status": "团员", "email": "2@qq.om", "home_address": "翻斗花园22022020号", "interesting": "写代码", "employment_intention": "程序员"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    '洋芋',
    '123456',
    '123456',
    1,
    '{"name": "洋芋"}',
    null
);

insert into users (name, account, password, type_info, information, image) values (
    'admin',
    'admin',
    '123456',
    2,
    '{"name": "admin"}',
    null
);

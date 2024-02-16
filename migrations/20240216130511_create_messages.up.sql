create table messages (
    id integer primary key not null,
    from_user_id integer not null,
    to_user_id integer not null,
    content text not null,
    created_at timestamp not null default current_timestamp
);

create index messages_from_user_id_index on messages (from_user_id);
create index messages_to_user_id_index on messages (to_user_id);

-- Example

insert into messages (from_user_id, to_user_id, content) values (1, 2, 'Hello, world!');

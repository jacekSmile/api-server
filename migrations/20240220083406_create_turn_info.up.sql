create table turn (
    id integer primary key not null,
    start_datetime text not null,
    end_datetime text not null,
    turn_id integer not null
);

create index turn_turn_id_index on turn (turn_id);

-- Example_data

insert into turn (start_datetime, end_datetime, turn_id) values (
    '2024-02-25 08:34:06',
    '2024-02-27 08:34:06',
    1
);

insert into turn (start_datetime, end_datetime, turn_id) values (
    '2024-03-20 08:34:06',
    '2024-04-20 08:34:06',
    2
);

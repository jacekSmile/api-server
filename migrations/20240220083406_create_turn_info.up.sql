create table turn (
    id integer primary key not null,
    start_datetime text not null,
    end_datetime text not null,
    turn_id integer not null
);

create index turn_turn_id_index on turn (turn_id);

-- Example_data

insert into turn (start_datetime, end_datetime, turn_id) values (
    '1993-10-31 16:23:31',
    '2021-04-27 02:44:32',
    1
);

insert into turn (start_datetime, end_datetime, turn_id) values (
    '2021-04-27 02:44:32',
    '2024-02-20 08:34:06',
    2
);

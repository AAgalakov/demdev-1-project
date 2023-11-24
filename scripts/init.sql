CREATE TABLE position_name
(
    id   uuid    not null
        constraint position_name_pk
            primary key,
    name varchar not null
);

CREATE TABLE staff
(
    id          uuid    not null
        constraint staff_pk
            primary key,
    name        varchar not null,
    position_id uuid
        constraint staff_position_name_id_fk
            references position_name
);

CREATE TABLE airport
(
    id        uuid    not null
        constraint airport_pk
            primary key,
    name      integer not null,
    longitude integer not null,
    width     integer not null
);

CREATE TABLE airplane_type
(
    id         uuid    not null
        constraint airplane_type_pk
            primary key,
    brand_name varchar not null,
    model      integer not null,
    capacity   integer not null
);

CREATE TABLE airplane
(
    id               uuid    not null
        constraint airplane_pk
            primary key,
    name             varchar not null,
    airplane_type_id uuid    not null
        constraint airplane_airplane_type_id_fk
            references airplane_type,
    register_number  varchar not null
);

CREATE TABLE flight
(
    number           integer   not null
        constraint flight_pk
            primary key,
    departure        uuid      not null
        constraint flight_airport_id_fk
            references airport,
    arrive           uuid      not null
        constraint flight_airport_id_fk2
            references airport,
    departure_time   timestamp not null,
    arrival_time     timestamp not null,
    airplane_type_id uuid      not null
        constraint flight_airplane_type_id_fk
            references airplane_type
);

CREATE TABLE flight_log
(
    id                        uuid      not null
        constraint flight_log_pk
            primary key,
    flight_log                timestamp,
    flight_number             integer   not null
        constraint table_name_flight_number_fk
            references flight,
    departure_actual_time     timestamp not null,
    arrival_actual_time       timestamp not null,
    arrival_actual_airport_id uuid
        constraint table_name_airport_id_fk
            references airport,
    airplane_id               uuid      not null
        constraint flight_log_airplane_id_fk
            references airplane,
    team_id                   uuid      not null
);

CREATE TABLE team
(
    id_staff      uuid not null
        constraint team_staff_id_fk
            references staff,
    flight_log_id uuid not null
        constraint team_flight_log_id_fk
            references flight_log
);
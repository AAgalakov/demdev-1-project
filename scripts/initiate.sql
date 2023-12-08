CREATE TABLE position_name
(
    id   UUID    NOT NULL
        CONSTRAINT position_name_pk
            PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL
);

CREATE TABLE staff
(
    id          UUID    NOT NULL
        CONSTRAINT staff_pk
            PRIMARY KEY DEFAULT gen_random_uuid(),
    name        VARCHAR NOT NULL,
    position_id UUID
        CONSTRAINT staff_position_name_id_fk
            REFERENCES position_name
);

CREATE TABLE airport
(
    id        UUID    NOT NULL
        CONSTRAINT airport_pk
            PRIMARY KEY DEFAULT gen_random_uuid(),
    name      VARCHAR NOT NULL,
    longitude numeric NOT NULL,
    latitude  numeric NOT NULL
);

CREATE TABLE airplane_type
(
    brand_name VARCHAR NOT NULL,
    model      INTEGER NOT NULL,
    capacity   INTEGER NOT NULL,
    id         SERIAL
        CONSTRAINT airplane_type_pk
            PRIMARY KEY
);

CREATE TABLE airplane
(
    id               UUID    NOT NULL
        CONSTRAINT airplane_pk
            PRIMARY KEY DEFAULT gen_random_uuid(),
    register_number  VARCHAR NOT NULL,
    airplane_type_id INTEGER
        CONSTRAINT airplane_airplane_type_id_fk
            REFERENCES airplane_type
);

CREATE TABLE flight
(
    number           INTEGER NOT NULL
        CONSTRAINT flight_pk
            PRIMARY KEY,
    departure        UUID    NOT NULL
        CONSTRAINT flight_airport_id_fk
            REFERENCES airport,
    arrive           UUID    NOT NULL
        CONSTRAINT flight_airport_id_fk2
            REFERENCES airport,
    airplane_type_id INTEGER
        CONSTRAINT flight_airplane_type_id_fk
            REFERENCES airplane_type,
    dep_time         TIME,
    duration_flight  INTEGER
);

CREATE TABLE flight_log
(
    id                        UUID      NOT NULL
        CONSTRAINT flight_log_pk
            PRIMARY KEY DEFAULT gen_random_uuid(),
    flight_log                TIMESTAMP,
    flight_number             INTEGER   NOT NULL
        CONSTRAINT table_name_flight_number_fk
            REFERENCES flight,
    departure_actual_time     TIMESTAMP NOT NULL,
    arrival_actual_time       TIMESTAMP NOT NULL,
    arrival_actual_airport_id UUID
        CONSTRAINT table_name_airport_id_fk
            REFERENCES airport,
    airplane_id               UUID      NOT NULL
        CONSTRAINT flight_log_airplane_id_fk
            REFERENCES airplane,
    team_id                   UUID      NOT NULL
);

CREATE TABLE team
(
    id_staff      UUID NOT NULL
        CONSTRAINT team_staff_id_fk
            REFERENCES staff,
    flight_log_id UUID NOT NULL
        CONSTRAINT team_flight_log_id_fk
            REFERENCES flight_log
);


INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Москва Шереметьево', 37.4146, 55.9726);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Москва Домодедово', 37.9063, 55.4088);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Москва Внуково', 37.2615, 55.5915);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Санкт-Петербург Пулково', 30.2625, 59.8003);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Екатеринбург Кольцово', 60.8027, 56.7431);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Сочи Адлер', 39.9411, 43.4488);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Краснодар Пашковский', 39.1739, 45.0347);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Новосибирск Толмачёво', 82.6678, 55.0126);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Уфа', 55.8744, 54.5575);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1a', 'Ростов-на-Дону (Платов)', 39.8181, 47.2582);
INSERT INTO airport (id, name, longitude, latitude) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1b', 'Мурманск', 33.0925, 68.9792);

INSERT INTO airplane_type (brand_name, model, capacity, id) VALUES ('Airbus', 320, 150, 1);
INSERT INTO airplane_type (brand_name, model, capacity, id) VALUES ('Airbus', 330, 300, 2);
INSERT INTO airplane_type (brand_name, model, capacity, id) VALUES ('Airbus', 350, 270, 3);
INSERT INTO airplane_type (brand_name, model, capacity, id) VALUES ('Boeing', 737, 170, 4);
INSERT INTO airplane_type (brand_name, model, capacity, id) VALUES ('Boeing', 777, 500, 5);
INSERT INTO airplane_type (brand_name, model, capacity, id) VALUES ('Boeing', 787, 230, 6);

INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'RA-12345', 3);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'RA-23456', 6);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'RA-34567', 3);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'RA-45678', 6);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'RA-56789', 2);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'RA-67890', 3);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'RA-78901', 4);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'RA-89012', 6);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'RA-90123', 4);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1a', 'RA-01234', 6);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1b', 'RA-12346', 2);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1c', 'RA-23457', 6);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1d', 'RA-34568', 3);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1e', 'RA-45679', 1);
INSERT INTO airplane (id, register_number, airplane_type_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1f', 'RA-56780', 1);

INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (102, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 1, '12:00:00', 240);
INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (107, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 6, '11:00:00', 120);
INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (101, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 4, '10:00:00', 90);
INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (100, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 4, '08:00:00', 90);
INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (103, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 1, '17:00:00', 240);
INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (105, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 6, '03:00:00', 240);
INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (106, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 4, '08:00:00', 120);
INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (108, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 3, '14:00:00', 240);
INSERT INTO flight (number, departure, arrive, airplane_type_id, dep_time, duration_flight) VALUES (104, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 5, '22:00:00', 240);

INSERT INTO position_name (id, name) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Пилот');
INSERT INTO position_name (id, name) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Стюардесса');
INSERT INTO position_name (id, name) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Бортинженер');
INSERT INTO position_name (id, name) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Бортпроводник');
INSERT INTO position_name (id, name) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15', 'Навигатор');

INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a16', 'Иван Иванов', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a17', 'Петр Петров', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a18', 'Анна Смирнова', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a19', 'Мария Иванова', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1a', 'Сергей Сергеев', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1b', 'Алексей Алексеев', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1c', 'Елена Петрова', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1d', 'Ольга Смирнова', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1e', 'Дмитрий Дмитриев', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15');
INSERT INTO staff (id, name, position_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a1f', 'Николай Николаев', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a15');


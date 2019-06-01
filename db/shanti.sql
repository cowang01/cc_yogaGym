DROP TABLE IF EXISTS feedbacks CASCADE;
DROP TABLE IF EXISTS sessions CASCADE;
DROP TABLE IF EXISTS members CASCADE;
DROP TABLE IF EXISTS teachers CASCADE;
DROP TABLE IF EXISTS rooms CASCADE;
DROP TABLE IF EXISTS types CASCADE;




CREATE TABLE types (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(64),
  colour VARCHAR(64),
  about TEXT
);

CREATE TABLE rooms (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(64),
  size INT4,
  image VARCHAR(64)
);

CREATE TABLE teachers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(64),
  bio TEXT,
  profile VARCHAR(64)
);

CREATE TABLE members (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(64),
  join_date DATE,
  waver BOOLEAN NOT NULL,
  info TEXT,
  membership DATE,
  membership_vol INT4
);

CREATE TABLE sessions (
  id SERIAL8 PRIMARY KEY,
  event_date DATE,
  event_time TIME,
  room_id INT8 REFERENCES rooms(id),
  teacher_id INT8 REFERENCES teachers(id),
  member_id TEXT,
  type_id INT8 REFERENCES types(id),
  status VARCHAR(64)
);

CREATE TABLE feedbacks (
  id SERIAL8 PRIMARY KEY,
  session_id INT8 REFERENCES sessions(id),
  feedback TEXT
);

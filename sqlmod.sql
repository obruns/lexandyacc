CREATE SCHEMA
AUTHORIZATION JOHNL

CREATE TABLE Foods (
  name CHAR(8) NOT NULL,
  type CHAR(5),
  flavor CHAR(6),
  PRIMARY KEY ( name )
)

CREATE TABLE Courses (
  course CHAR(8) NOT NULL PRIMARY KEY,
  flavor CHAR(6),
  sequence INTEGER
);

-- test

SELECT Foods.name, Foods.flavor
FROM Foods
WHERE Foods.type = 'fruit';

SELECT course, name, Foods.flavor, type
FROM Courses, Foods
WHERE Courses.flavor = Foods.flavor;

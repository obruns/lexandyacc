#!/bin/sh
set -e -o pipefail
set -u

# page 110
./sql1 sqlmod.sql

# page 124
./sql1 <<EOF
CREATE VIEW fruits (frname, frflavor)
  AS SELECT Foods.name, Foods.flavor
  FROM FOODS
  WHERE Foods.thype = 'fruit';
EOF

# page 126
./sql1 <<EOF
GRANT SELECT, UPDATE (address, telephone)
  ON employees TO PUBLIC;

GRANT ALL ON foods TO tony, dale WITH GRANT OPTION;
-- allows the grantees to re-grant their authority to other users

GRANT REFERENCES (flavor) ON Foods TO PUBLIC;
-- the authority needed to create a table keyed to a column in an existing table.
EOF

# page 127
./sql1 <<EOF
DECLARE course_cur CURSOR FOR
  SELECT ALL
  FROM Courses
  ORDER BY sequence ASC;
EOF

# for page 130
# using data from page 110
./sql1 <<EOF
INSERT INTO Foods (name, type, flavor) VALUES
  ('peach', 'fruit', 'sweet'),
  ('tomato', 'fruit', 'savory'),
  ('lemon', 'fruit', 'sour'),
  ('lard', 'fat', 'bland'),
  ('cheddar', 'fat', 'savory');

INSERT INTO Courses (course, flavor, sequence) VALUES
  ('salad', 'savory', 1),
  ('main', 'savory', 2),
  ('dessert', 'sweet', 3);
EOF

# page 131
./sql1 <<EOF
DELETE FROM Foods WHERE type = sweet;
DELETE FROM Courses WHERE sequence < 3;
EOF

# page 131; fails, cannot explain, why
./sql1 <<EOF
UPDATE Foods SET type = 'Fruit' WHERE flavor = 'sweet';
EOF

# page 133
./sql1 <<EOF
SELECT SUM( (p.age*p.age) / COUNT( p.age ) ) - AVG( p.age ) * AVG( p.age ) FROM p;
EOF

# page 135
./sql1 <<EOF
SELECT supplier
FROM p
GROUP BY supplier
HAVING COUNT(*) >= 3;
EOF

# page 137
./sql1 <<EOF
SELECT age FROM p WHERE p.age BETWEEN 21 AND 65;
SELECT age FROM p WHERE p.age >= 21 AND p.age <= 65;
EOF

# page 139
./sql1 <<EOF
SELECT * FROM q WHERE q.Name IN ( 'Tom', 'Dick', 'Harry' );
SELECT * FROM q WHERE q.Name = 'Tom' OR q.Name = 'Dick' OR q.Name = 'Harry';
EOF

# page 140
./sql1 <<EOF
FETCH foo INTO
:a ,
b c, -- two names are legal
d e f--but three aren't
EOF

# page 90
#./sql1 <<EOF
#EOF

# page 98
#./sql1 <<EOF
#EOF

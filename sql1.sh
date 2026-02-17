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

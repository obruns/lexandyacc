#!/bin/sh
set -e -o pipefail
set -u

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

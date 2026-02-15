#!/bin/sh
set -e -o pipefail
set -u

./ch3-01.pgm <<EOF
12 + 13
EOF

./ch3-01.pgm <<EOF
14 + 23 - 11 + 7
EOF

#!/bin/sh
set -e -o pipefail
set -u

./ch3-03.pgm <<EOF
2/3
a = 2/7
a
z = a+1
z
a/z
$
EOF

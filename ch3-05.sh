#!/bin/sh
set -e -o pipefail
set -u

./ch3-05.pgm <<EOF
s2 = sqrt(2)
s2
s2*s2
$
EOF

./ch3-05.pgm <<EOF
sqrt(3)
foo(3)
sqrt = 5
sqrt(sqrt)
$
EOF

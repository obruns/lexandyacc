#!/bin/sh
set -e -o pipefail
set -u

./ch3-02.pgm <<EOF
2+3*4
EOF

./ch3-02.pgm <<EOF
3-4-5-6
EOF

#!/bin/sh
set -e -o pipefail
set -u

./ch2-07.pgm <<EOF
magic
two
three
EOF

#!/bin/sh
set -e -o pipefail
set -u

./ch2-04.pgm <<EOF
-h
EOF
./ch2-04.pgm <<EOF
-?
EOF
./ch2-04.pgm <<EOF
-help
EOF
./ch2-04.pgm <<EOF
-v
EOF
./ch2-04.pgm <<EOF
-verbose
EOF
./ch2-04.pgm <<EOF
-f ch2-04.l
EOF
./ch2-04.pgm <<EOF
-file ch2-04.l
EOF

#!/bin/sh
set -e -o pipefail
set -u

./ch3-04.pgm <<EOF
foo = 12
foo /5
thisisanextremelylongvariablenamewhichnobodywouldwanttotype = 42
3 * thisisanextremelylongvariablenamewhichnobodywouldwanttotype
$
EOF

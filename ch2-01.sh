#!/bin/sh
set -e -o pipefail
set -u
set -x

# echo "123 hello world 0.0 and 4.5 or .31415 is pi and e12 should also be matched and 0xdeadbeef is not" | ./ch2-01.pgm

./ch2-01.pgm <<EOF
integer 123
negative integer -456
positive integer +789
float 0.0
signed float -4.5
just decimal point .31415
scientific notation 1e3
signed scientific notation -7e-10
binary 0b01
binary 0b010101
oct 0755
oct 0644
hex 0xdeadbeef
hex 0xdefec8ed
hex 0xc0ffee
EOF

#!/bin/sh
set -e -o pipefail
set -u

./ape-05.pgm -h
./ape-05.pgm -?
./ape-05.pgm -help
./ape-05.pgm -v
./ape-05.pgm -verbose
./ape-05.pgm -f ch2-04.l
./ape-05.pgm -file ch2-04.l

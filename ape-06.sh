#!/bin/sh
set -e -o pipefail
set -u

./ape-06.pgm -h
./ape-06.pgm -?
./ape-06.pgm -help
./ape-06.pgm -v
./ape-06.pgm -verbose
./ape-06.pgm -f ch2-04.l
./ape-06.pgm -file ch2-04.l

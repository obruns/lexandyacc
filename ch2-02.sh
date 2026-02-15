#!/bin/sh
set -e -o pipefail
set -u

wc ch2-02.l
./ch2-02.pgm ch2-02.l

wc ch1-05.txt
./ch2-02.pgm ch1-05.txt

wc TPLY.TEX
./ch2-02.pgm TPLY.TEX

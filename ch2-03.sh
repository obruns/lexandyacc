#!/bin/sh
set -e -o pipefail
set -u

wc ch2-02.l ch1-05.txt TPLY.TEX
./ch2-03.pgm ch2-02.l ch1-05.txt TPLY.TEX

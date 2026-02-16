#!/bin/sh
set -e -o pipefail
set -u

./ch2-09.pgm <<EOF
/* this is a normal ANSI C comment */
/* comment */ /* comment
*/
int counter; /* this is
      a strange comment */
int counter; /* comment */

/* comment */ int counter;

/* comment # 1 */ int counter; /* comment # 2 */
/* this is the beginning of a comment
   and this is the end */ int counter;

EOF

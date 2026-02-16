#!/bin/sh
set -e -o pipefail
set -u

# page 82
#./mgl <<EOF
#screen myMenu
#title "My First Menu"
#title "by Tony Mason"
#
#item "List Things to Do"
#command "to-do"
#action execute list-things-todo
#attribute command
#
#item "Quit"
#command "quit"
#action quit
#
#end myMenu
#EOF

# page 90
./mgl <<EOF
screen main
title "Main screen"
item "fruits" command fruits action menu fruits
item "grains" command grains action menu grains
item "quit" command Quit action quit
end main

screen fruits
title "Fruits"
item "grape" command grape action execute "/fruit/grape"
item "melon" command melon action execute "/fruit/melon"
item "main" command main action menu main
end fruits

screen grains
title "Grains"
item "wheat" command wheat action execute "/grain/wheat"
item "barley" command barley action execute "/grain/barley"
item "main" command main action menu main
end grains
EOF

# page 98
./mgl <<EOF
screen first
title "First"
title "Copyright 1992"

item "first" command first action ignore
  attribute visible
item "second" command second action execute "/bin/sh"
  attribute visible
end first

screen second
title "Second"
item "second" command second action menu first
  attribute visible
item "first" command first action quit
  attribute invisible
end second
EOF

# move(0,37);
# addstr("First");
# refresh();
# move(1,32);
# addstr("Copyright 1992");
# refresh();

# page 103
./mgl <<EOF
screen first
title "First"

item "dummy line" command dummy action ignore
  attribute visible
item "run shell" command shell action execute "/bin/sh"
  attribute visible
end first

screen second
title "Second"
item "exit program" command exit action quit
  attribute invisible
item "other menu" command first action menu first
  attribute visible
end second
EOF

mv screen.out mgl-demo.c

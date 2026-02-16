#pragma once

int start_screen(char *name);
void add_title(char *line);
void add_line(int action, int attrib);
int end_screen(char *name);
void process_items();
void dump_data(char **array);
void end_file();
void cfree(char *p);
int check_name(char *name);
void warning(char *name, char *screen);

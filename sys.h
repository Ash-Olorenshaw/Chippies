#ifndef SYS

typedef struct {
	char *name;
	bool term;
} executable;

bool find_program(char *target, executable *found);

#endif 

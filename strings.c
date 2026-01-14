#include <stdlib.h>
#include <ctype.h>

char *str_lower(char *target) {
	char *result = target;

	if (target == NULL) 
		return target;

	while (*target) {
		*target = tolower(*target);
		target++;
	}

	return result;
}


char *str_f_part(char *target) {
	char *result = target;

	if (target == NULL) 
		return target;

	while (*target != ' ') {
		*target = tolower(*target);
		target++;
	}
	
	*target = '\0';
	return result;
}


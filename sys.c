#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <dirent.h>

#include "strings.h"
#include "globals.h"

typedef struct {
	char *name;
	bool term;
} executable;

bool find_application(char *target, char *found);
bool find_binary(const char *command);

bool find_program(char *target, executable *found) {
	char res[MAX_INPUT_CHARS];
	if (find_binary(target)) {
    	strncpy(found->name, target, MAX_INPUT_CHARS);
		found->term = true;
		return true;
	}
	else if (find_application(target, res)) {
    	strncpy(found->name, res, MAX_INPUT_CHARS);
		found->term = false;
		return true;
	} 
	return false;
}

bool find_application(char *target, char *found) {
	DIR *dr = opendir("/Applications/");
	struct dirent *de;

	if (dr == NULL) {
		fprintf(stderr, "Could not open directory '/Applications/\n");
		exit(1);
	}    

	char target_lower[MAX_INPUT_CHARS];
    strncpy(target_lower, target, MAX_INPUT_CHARS);
    str_lower(target_lower);

	while ((de = readdir(dr)) != NULL) {
		char file_name[MAX_INPUT_CHARS];
		strncpy(file_name, de->d_name, MAX_INPUT_CHARS);
		str_lower(file_name);

		if (strstr(file_name, target_lower)) {
			strncpy(found, file_name, MAX_INPUT_CHARS);
			closedir(dr);
			return true;
		}
	}

	closedir(dr); 
	return false;
}

bool find_binary(const char *command) {
#define DESTRUCT(res) ({ free(path_copy); return res; })
    char *path_env = getenv("PATH");
    if (path_env == NULL) return false;

    char *path_copy = strdup(path_env);
    char *dir = strtok(path_copy, ":");
    char full_path[1024];

	char executable[MAX_INPUT_CHARS];
	strcpy(executable, command);
	str_f_part(executable);

    while (dir != NULL) {
        snprintf(full_path, sizeof(full_path), "%s/%s", dir, executable);
        if (access(full_path, X_OK) == 0)
			DESTRUCT(true);
        dir = strtok(NULL, ":");
    }
	DESTRUCT(false);
}

#include <string.h>
#include <stdio.h>

#include "raylib/include/raylib.h"
#include "globals.h"
#include "sys.h"

void render_loop(char *input_text, int *letter_count, Rectangle text_box) {
	int key = GetCharPressed();

	while (key > 0) {
		if ((key >= 32) && (key <= 125) && (*letter_count < MAX_INPUT_CHARS)) {
			input_text[*letter_count] = (char)key;
			(*letter_count)++;
		}
		key = GetCharPressed();
	}

	if (IsKeyPressed(KEY_BACKSPACE)) {
		(*letter_count)--;
		if (*letter_count < 0) {
			*letter_count = 0;
		}
		input_text[*letter_count] = '\0';
	}
	
	if (IsKeyPressed(KEY_ENTER)) {
		char command_name[MAX_INPUT_CHARS] = "";
		executable command = { .name = command_name, .term = false };
		if (find_program(input_text, &command)) {
			if (command.term)
				printf("Running cmd: %s\n", command.name);
			else
				printf("Running: %s\n", command.name);
		}
		
		*letter_count = 0;
		memset(input_text, 0, strlen(input_text));
	}

	BeginDrawing();

		ClearBackground(DARKGRAY);
		
		char command_name[MAX_INPUT_CHARS] = "";
		executable command = { .name = command_name, .term = false };
		Color current_text_col = find_program(input_text, &command) ? DARKGREEN : LIGHTGRAY;
		DrawText(input_text, text_box.x + 5, text_box.y + 20, 20, current_text_col);

		char output_text[MAX_INPUT_CHARS];
		if (command.term) {
			strncpy(output_text, "Executing: ", MAX_INPUT_CHARS);
			strcat(output_text, command.name);
		}
		else {
			strncpy(output_text, "Opening: ", MAX_INPUT_CHARS);
			strcat(output_text, command.name);
		}
		
		DrawText(output_text, text_box.x + 5, text_box.y + 50, 10, LIGHTGRAY);

	EndDrawing();
}

int main(void) {
	InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Chippies");
	SetWindowState(FLAG_WINDOW_UNDECORATED);
	SetTargetFPS(60);

	char input_text[MAX_INPUT_CHARS + 1] = "\0";
	int letter_count = 0;
	Rectangle text_box = { 5, 55, 390, 40 };

	while (!WindowShouldClose()) {
		render_loop(input_text, &letter_count, text_box);
	}

	CloseWindow();
	return 0;
}

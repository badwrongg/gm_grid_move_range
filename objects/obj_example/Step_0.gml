if (keyboard_check_pressed(vk_escape))
{
	game_end();
	exit;
}

if (keyboard_check_pressed(vk_space))
	show_range = !show_range;

cell_x     = (mouse_x &~ TILE_SIZE_M1) + TILE_SIZE_HALF;
cell_y     = (mouse_y &~ TILE_SIZE_M1) + TILE_SIZE_HALF;
move_range = clamp(move_range + mouse_wheel_up() - mouse_wheel_down(), 0, 15);
no_path    = (path_position == 1 || path_position == 0);

// If not pathing and mouse clicked start new path if valid and in range
if (no_path && mouse_check_button_pressed(mb_left))
{	
	if (mp_grid_path(grid_id, move_path, x, y, cell_x, cell_y, false) && path_get_number(move_path) - 1 <= move_range)
		path_start(move_path, 4, path_action_stop, false);
}
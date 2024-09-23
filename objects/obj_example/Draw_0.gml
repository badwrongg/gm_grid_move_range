var _select_color = c_red;

// If not pathing draw the movement range and potential path
if (no_path)
{
	if (show_range)
		mp_grid_draw_move_range_at_pixel(spr_move_cell, 0, x, y, grid_id, move_range);
	
	if (mp_grid_path(grid_id, move_path, x, y, cell_x, cell_y, false))
	{
		if (path_get_number(move_path) - 1 <= move_range)
		{
			draw_path(move_path, x, y, true);
			_select_color = c_white;
		}
	}
}

draw_sprite_ext(spr_cell_selection, 0, mouse_x &~ TILE_SIZE_M1, mouse_y &~ TILE_SIZE_M1, 1, 1, 0, _select_color, 1);
draw_self();
draw_sprite(spr_cursor, 0, mouse_x, mouse_y);
// Create an mp_grid the same size as the tilemap
var _tile_id  = layer_tilemap_get_id(layer_get_id("tile_collision")),
	_columns  = tilemap_get_width(_tile_id),
	_rows     = tilemap_get_height(_tile_id),
	_grid_id  = mp_grid_create(0, 0, _columns, _rows, tilemap_get_tile_width(_tile_id), tilemap_get_tile_height(_tile_id));

// Populate mp_grid with the tilemap
for (var _c = 0; _c < _columns; _c++)
	for (var _r = 0; _r < _rows; _r++)
		if (tilemap_get(_tile_id, _c, _r))
			mp_grid_add_cell(_grid_id, _c, _r);
			
grid_id	   = _grid_id;
move_range = 4;
move_path  = path_add();
no_path    = true;
cell_x     = x;
cell_y     = y;
show_range = true;

#macro TILE_SIZE 32
#macro TILE_SIZE_M1 31
#macro TILE_SIZE_HALF 16

show_debug_overlay(true);
window_set_cursor(cr_none);
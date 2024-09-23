/*
GameMaker solution for drawing mp_grid movement
Author: Nathan Hunter, badwronggames@gmail.com
 
//////////////////////////////////////////////
 
MIT License
 
Copyright (c) 2023 Nathan Hunter
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 
//////////////////////////////////////////////

SETUP: Copy the code below into a script file
USE: Call the functions mp_grid_draw_move_range() or mp_grid_draw_move_range_at_pixel()

*/


/// @function						mp_grid_draw_move_range(_sprite, _image_index, _x, _y, _grid, _range)
/// @param {asset}   _sprite		The sprite to draw, should be same size as the mp_grid's cells
/// @param {integer} _image_index   The index of the sprite to use
/// @param {integer} _x				The x position in the grid (not room coordinates)
/// @param {integer} _y				The y position in the grid (not room coordinates)
/// @param {index}   _grid			The mp_grid to use
/// @param {integer} _range			The movement range
/// @description					Draws a sprite at all valid cells in an mp_grid within the given movement range from a cell at x and y
function mp_grid_draw_move_range(_sprite, _image_index, _x, _y, _grid, _range)
{
	// A grid to track visisted cells and its size
	static _visited = ds_grid_create(0, 0);
	static _size = 0;
	
	// Size is double plus one on both horizontal and vertical
	var _new_size = _range * 2 + 1,
		_start    = _range;
		
	// Resize the grid if size changed
	if (_size != _new_size)
	{
		_size = _new_size;
		ds_grid_resize(_visited, _new_size, _new_size);
	}
	
	// Clear all to -1
	ds_grid_clear(_visited, -1);
	
	// Begin recursive call at this cell
	__mp_grid_draw_move_range_recursive(_sprite, _image_index, _x, _y, _grid, _range, _visited, _start, _start);
}

/// @function						mp_grid_draw_move_range_at_pixel(_sprite, _image_index, _x, _y, _grid, _range)
/// @param {asset}   _sprite		The sprite to draw, should be same size as the mp_grid's cells
/// @param {integer} _image_index   The index of the sprite to use
/// @param {integer} _x				The x position in the room
/// @param {integer} _y				The y position in the room
/// @param {index}   _grid			The mp_grid to use
/// @param {integer} _range			The movement range
/// @description					Draws a sprite at all valid cells in an mp_grid within the given movement range from the x and y position
function mp_grid_draw_move_range_at_pixel(_sprite, _image_index, _x, _y, _grid, _range)
{
	// Wrapper function of mp_grid_draw_move_range() that uses absolute coordinates instead grid cell position
	mp_grid_draw_move_range(_sprite, _image_index, _x div sprite_get_width(_sprite), _y div sprite_get_height(_sprite), _grid, _range);
}

/// @function		__mp_grid_draw_move_range_recursive(_sprite, _image_index, _x, _y, _grid, _range)
/// @description	Recursive function call for mp_grid_draw_move_range functions. DO NOT call directly!
function __mp_grid_draw_move_range_recursive(_sprite, _image_index, _x, _y, _grid, _range, _visited, _vx, _vy)
{
	// Stop here if this cell is occupied
	if (mp_grid_get_cell(_grid, _x, _y) == -1)
		return;
	
	// If a equal or greater cost is here then its already been checked
	var _cost = _visited[# _vx, _vy];
	if (_cost >= _range)
		return;
	
	// Nothing was drawn yet if still -1 
	if (_cost == -1)
		draw_sprite(_sprite, _image_index, 
			_x * sprite_get_width(_sprite)  + sprite_get_xoffset(_sprite), 
			_y * sprite_get_height(_sprite) + sprite_get_yoffset(_sprite));
	
	// Track the current range in this cell
	_visited[# _vx, _vy] = _range;
		
	// Check if finished
	if (--_range == -1)
		return;
	
	// Call recursion on the fource adjacent cells
	__mp_grid_draw_move_range_recursive(_sprite, _image_index, _x + 1, _y, _grid, _range, _visited, _vx + 1, _vy);	
	__mp_grid_draw_move_range_recursive(_sprite, _image_index, _x - 1, _y, _grid, _range, _visited, _vx - 1, _vy);	
	__mp_grid_draw_move_range_recursive(_sprite, _image_index, _x, _y + 1, _grid, _range, _visited, _vx, _vy + 1);	
	__mp_grid_draw_move_range_recursive(_sprite, _image_index, _x, _y - 1, _grid, _range, _visited, _vx, _vy - 1);
}
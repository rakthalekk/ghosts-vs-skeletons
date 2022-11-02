extends TileMap


func trigger_stairs():
	var active_right_stairs = get_used_cells_by_id(0)
	var inactive_right_stairs = get_used_cells_by_id(1)
	var active_left_stairs = get_used_cells_by_id(2)
	var inactive_left_stairs = get_used_cells_by_id(3)
	var active_left_platforms = get_used_cells_by_id(4)
	var inactive_left_platforms = get_used_cells_by_id(5)
	var active_right_platforms = get_used_cells_by_id(6)
	var inactive_right_platforms = get_used_cells_by_id(7)
	
	for stair in active_left_stairs:
		set_cellv(stair, 3, false, false, false, get_cell_autotile_coord(stair.x, stair.y))
	
	for stair in inactive_left_stairs:
		set_cellv(stair, 2, false, false, false, get_cell_autotile_coord(stair.x, stair.y))
	
	for stair in active_right_stairs:
		set_cellv(stair, 1, false, false, false, get_cell_autotile_coord(stair.x, stair.y))
	
	for stair in inactive_right_stairs:
		set_cellv(stair, 0, false, false, false, get_cell_autotile_coord(stair.x, stair.y))
	
	for stair in active_left_platforms:
		set_cellv(stair, 5, false, false, false, get_cell_autotile_coord(stair.x, stair.y))
	
	for stair in inactive_left_platforms:
		set_cellv(stair, 4, false, false, false, get_cell_autotile_coord(stair.x, stair.y))
	
	for stair in active_right_platforms:
		set_cellv(stair, 7, false, false, false, get_cell_autotile_coord(stair.x, stair.y))
	
	for stair in inactive_right_platforms:
		set_cellv(stair, 6, false, false, false, get_cell_autotile_coord(stair.x, stair.y))

extends Area2D

onready var stairs = get_parent().get_node("Stairs")

func activate():
	trigger_stairs()


func trigger_stairs():
	var active_right_stairs = stairs.get_used_cells_by_id(0)
	var inactive_right_stairs = stairs.get_used_cells_by_id(1)
	var active_left_stairs = stairs.get_used_cells_by_id(2)
	var inactive_left_stairs = stairs.get_used_cells_by_id(3)
	var active_platforms = stairs.get_used_cells_by_id(4)
	var inactive_platforms = stairs.get_used_cells_by_id(5)
	
	for stair in active_left_stairs:
		stairs.set_cellv(stair, 3)
	
	for stair in inactive_left_stairs:
		stairs.set_cellv(stair, 2)
	
	for stair in active_right_stairs:
		stairs.set_cellv(stair, 1)
	
	for stair in inactive_right_stairs:
		stairs.set_cellv(stair, 0)
	
	for stair in active_platforms:
		stairs.set_cellv(stair, 5)
	
	for stair in inactive_platforms:
		stairs.set_cellv(stair, 4)

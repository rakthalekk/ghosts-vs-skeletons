extends Area2D

onready var stairs = get_parent().get_parent().get_node("Stairs")
onready var map = get_parent().get_parent()

func activate():
	stairs.trigger_stairs()
	map.emit_signal("update_minimap_stairs")

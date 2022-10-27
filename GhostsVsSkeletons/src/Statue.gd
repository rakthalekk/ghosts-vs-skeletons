extends Area2D

onready var stairs = get_parent().get_node("Stairs")

func activate():
	stairs.trigger_stairs()
	get_parent().emit_signal("update_minimap_stairs")

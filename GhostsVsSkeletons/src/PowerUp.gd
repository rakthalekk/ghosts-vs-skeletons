class_name PowerUp
extends Area2D

onready var manager = get_parent().get_parent().get_parent()

func delete_self():
	manager.remove_powerup(self)
	queue_free()

extends Area2D

const HAPPY = preload("res://assets/Happy Statue_20221031133621.png")
const MAD = preload("res://assets/Mad Statue_20221031133628.png")

onready var stairs = get_parent().get_parent().get_node("Stairs")
onready var map = get_parent().get_parent()

func activate():
	stairs.trigger_stairs()
	map.activate_statue()


func switch_texture():
	if $Sprite.texture == HAPPY:
		$Sprite.texture = MAD
	else:
		$Sprite.texture = HAPPY

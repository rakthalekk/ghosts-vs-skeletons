extends Sprite

const HUMAN = preload("res://src/Human.tscn")

export(bool) var double_door = false

onready var map = get_parent().get_parent()

func _ready():
	if double_door:
		$SpawnTimer.start(rand_range(5, 10))
	else:
		$SpawnTimer.start(rand_range(10, 15))

func _on_SpawnTimer_timeout():
	map.emit_signal("create_human_icon")
	var human = HUMAN.instance()
	human.global_position = global_position
	map.get_node("Humans").add_child(human)
	if double_door:
		$SpawnTimer.start(rand_range(5, 10))
	else:
		$SpawnTimer.start(rand_range(10, 15))

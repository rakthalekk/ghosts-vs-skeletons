extends Sprite

const HUMAN = preload("res://src/Human.tscn")

export(bool) var double_door = false

func _ready():
	if double_door:
		$SpawnTimer.start(rand_range(5, 10))
	else:
		$SpawnTimer.start(rand_range(10, 15))

func _on_SpawnTimer_timeout():
	get_parent().emit_signal("create_human_icon")
	var human = HUMAN.instance()
	human.global_position = global_position
	get_parent().get_node("Humans").add_child(human)
	if double_door:
		$SpawnTimer.start(rand_range(5, 10))
	else:
		$SpawnTimer.start(rand_range(10, 15))

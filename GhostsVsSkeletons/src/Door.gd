extends Sprite

const HUMAN = preload("res://src/Human.tscn")


func _on_SpawnTimer_timeout():
	var human = HUMAN.instance()
	human.global_position = global_position
	get_parent().add_child(human)

extends Sprite

const HUMAN = preload("res://src/Human.tscn")


func _on_SpawnTimer_timeout():
	get_parent().emit_signal("create_human_icon")
	var human = HUMAN.instance()
	human.global_position = global_position
	get_parent().get_node("Humans").add_child(human)

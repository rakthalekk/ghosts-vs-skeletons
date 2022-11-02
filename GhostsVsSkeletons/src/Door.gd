extends Sprite

const HUMAN = preload("res://src/Human.tscn")

export(bool) var double_door = false

onready var map = get_parent().get_parent()

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	if double_door:
		$SpawnTimer.start(rng.randf_range(5, 10))
		texture = load("res://assets/Double Door.png")
	else:
		$SpawnTimer.start(rng.randf_range(10, 15))

func _on_SpawnTimer_timeout():
	map.emit_signal("create_human_icon")
	var human = HUMAN.instance()
	human.gender = "male" if rng.randi_range(0, 1) == 0 else "female"
	human.global_position = global_position
	map.get_node("Humans").add_child(human)
	if double_door:
		$SpawnTimer.start(rng.randf_range(5, 10))
	else:
		$SpawnTimer.start(rng.randf_range(10, 15))

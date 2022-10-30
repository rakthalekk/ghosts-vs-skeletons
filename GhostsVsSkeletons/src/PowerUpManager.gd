extends Node2D

export(Vector2) var level_size = Vector2(4554, 4554)
export(Vector2) var powerup_spawn_rate = Vector2(10, 20)

const CROSS = preload("res://src/Cross.tscn")
const HOLYWATER = preload("res://src/HolyWater.tscn")

var powerups = [CROSS, HOLYWATER]

var rng = RandomNumberGenerator.new()

onready var tilemap = get_parent().get_node("Foreground")

var activeLocations = []
var inactiveLocations = []

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$PowerupTimer.start(rng.randf_range(powerup_spawn_rate.x, powerup_spawn_rate.y))
	
	for location in $Locations.get_children():
		inactiveLocations.append(location)


func remove_powerup(powerup):
	var location = powerup.get_parent()
	activeLocations.erase(location)
	inactiveLocations.append(location)
	get_parent().emit_signal("remove_powerup_icon", powerup)


func _on_PowerupTimer_timeout():
	if inactiveLocations.size() == 0:
		$PowerupTimer.start(rng.randf_range(powerup_spawn_rate.x, powerup_spawn_rate.y))
		return
	
	var idx = rng.randi_range(0, inactiveLocations.size() - 1)
	var location = inactiveLocations[idx]
	inactiveLocations.remove(idx)
	activeLocations.append(idx)
	
	var powerup
	if location.get_name() == "CrossPosition":
		powerup = CROSS.instance()
	elif location.get_name() == "HolyWaterPosition":
		powerup = HOLYWATER.instance()
	else:
		powerup = powerups[rng.randi_range(0, powerups.size() - 1)].instance()
	
	location.add_child(powerup)
	get_parent().emit_signal("create_powerup_icon", powerup)
	
	$PowerupTimer.start(rng.randf_range(powerup_spawn_rate.x, powerup_spawn_rate.y))

extends ColorRect


onready var map = $"../HBoxContainer/ViewportContainer/Viewport/Map"
onready var skeleton = map.get_node("SkeletonPlayer")
onready var ghost = map.get_node("GhostPlayer")
onready var foreground = map.get_node("Foreground")
onready var stairs = map.get_node("Stairs")
onready var platforms = map.get_node("Platforms")
onready var humans = map.get_node("Humans")
onready var statues = map.get_node("Statues")

var human_icons = []
var powerup_icons = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for statue in statues.get_children():
		var s = Sprite.new()
		s.texture = load("res://icon.png")
		s.scale = Vector2(0.3, 0.3)
		s.position = statue.global_position / 14.2 - Vector2(0, 10)
		$StatueIcons.add_child(s)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SkeletonIcon.position = skeleton.global_position / 14.2
	$GhostIcon.position = ghost.global_position / 14.2
	
	var index = 0
	for human in humans.get_children():
		human_icons[index].texture = human.get_node("Sprite").texture
		human_icons[index].position = human.global_position / 14.2
		index += 1


func _on_Map_update_minimap_stairs():
	$Stairs.trigger_stairs()


func _on_Map_create_human_icon():
	var human_icon = Sprite.new()
	human_icon.scale = Vector2(0.3, 0.3)
	$HumanIcons.add_child(human_icon)
	human_icons.append(human_icon)


func _on_Map_create_powerup_icon(powerup):
	var powerup_icon = Sprite.new()
	powerup_icon.scale = Vector2(0.3, 0.3)
	powerup_icon.texture = powerup.get_node("Sprite").texture
	powerup_icon.position = powerup.global_position / 14.2
	powerup_icon.modulate = powerup.modulate
	$PowerupIcons.add_child(powerup_icon)
	powerup_icons.append(powerup_icon)


func _on_Map_remove_powerup_icon(powerup):
	# Removes the icon at the position of the removed powerup
	for icon in powerup_icons:
		if icon.position.distance_to(powerup.global_position / 14.2) < 5:
			powerup_icons.erase(icon)
			icon.queue_free()
			break

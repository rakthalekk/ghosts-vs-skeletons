extends ColorRect


onready var map = $"../HBoxContainer/ViewportContainer/Viewport/Map"
onready var skeleton = map.get_node("SkeletonPlayer")
onready var ghost = map.get_node("GhostPlayer")
onready var foreground = map.get_node("Foreground")
onready var stairs = map.get_node("Stairs")
onready var platforms = map.get_node("Platforms")
onready var humans = map.get_node("Humans")

var human_icons = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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

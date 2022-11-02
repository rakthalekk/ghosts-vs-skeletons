extends ColorRect

const BONESPRITE = preload("res://assets/Bone.png")
const ORBSPRITE = preload("res://assets/Orb.png")
var projectile_sprite = BONESPRITE

const WATERSPRITE = preload("res://assets/Holy Water.png")
const CROSSSPRITE = preload("res://assets/Cross.png")
var slow_sprite = WATERSPRITE

const HAPPY = preload("res://assets/Happy Statue_20221031133621.png")
const MAD = preload("res://assets/Mad Statue_20221031133628.png")
var statue_sprite = HAPPY

const HUMAN_BOY = preload("res://assets/Human Boy Alive Icon.png")
const HUMAN_BOY_SKELETON = preload("res://assets/Human Boy Skeleton Icon.png")
const HUMAN_BOY_GHOST = preload("res://assets/Human Boy Ghost Icon.png")
const HUMAN_GIRL = preload("res://assets/Human Girl Alive Icon.png")
const HUMAN_GIRL_SKELETON = preload("res://assets/Human Girl Skeleton Icon.png")
const HUMAN_GIRL_GHOST = preload("res://assets/Human Girl Ghost Icon.png")

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
		s.texture = HAPPY
		s.scale = Vector2(0.3, 0.3)
		s.position = statue.global_position / 14.2 - Vector2(0, 18)
		$StatueIcons.add_child(s)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SkeletonIcon.position = skeleton.global_position / 14.2
	$GhostIcon.position = ghost.global_position / 14.2
	
	var index = 0
	for human in humans.get_children():
		if human.gender == "male":
			if human.type == "alive":
				human_icons[index].texture = HUMAN_BOY
			elif human.type == "skeleton":
				human_icons[index].texture = HUMAN_BOY_SKELETON
			else:
				human_icons[index].texture = HUMAN_BOY_GHOST
		else:
			if human.type == "alive":
				human_icons[index].texture = HUMAN_GIRL
			elif human.type == "skeleton":
				human_icons[index].texture = HUMAN_GIRL_SKELETON
			else:
				human_icons[index].texture = HUMAN_GIRL_GHOST
		
		human_icons[index].position = human.global_position / 14.2
		index += 1


func _on_Map_update_minimap_stairs():
	if statue_sprite == HAPPY:
		statue_sprite= MAD
	else:
		statue_sprite = HAPPY
	for statue in $StatueIcons.get_children():
		statue.texture = statue_sprite
	
	$Stairs.trigger_stairs()


func _on_Map_create_human_icon():
	var human_icon = Sprite.new()
	$HumanIcons.add_child(human_icon)
	human_icons.append(human_icon)


func _on_Map_create_powerup_icon(powerup):
	var powerup_icon = Sprite.new()
	powerup_icon.texture = powerup.get_node("Sprite").texture
	
	powerup_icon.position = powerup.global_position / 14.2 - Vector2(0, 10)
	$PowerupIcons.add_child(powerup_icon)
	powerup_icons.append(powerup_icon)


func _on_Map_remove_powerup_icon(powerup):
	# Removes the icon at the position of the removed powerup
	for icon in powerup_icons:
		if icon.position.distance_to(powerup.global_position / 14.2 - Vector2(0, 10)) < 5:
			powerup_icons.erase(icon)
			icon.queue_free()
			break


func _on_AlternateIcons_timeout():
	if projectile_sprite == BONESPRITE:
		projectile_sprite = ORBSPRITE
	else:
		projectile_sprite = BONESPRITE
	
	if slow_sprite == WATERSPRITE:
		slow_sprite = CROSSSPRITE
	else:
		slow_sprite = WATERSPRITE
	
	for icon in powerup_icons:
		if icon.texture == BONESPRITE || icon.texture == ORBSPRITE:
			icon.texture = projectile_sprite
		elif icon.texture == WATERSPRITE || icon.texture == CROSSSPRITE:
			icon.texture = slow_sprite

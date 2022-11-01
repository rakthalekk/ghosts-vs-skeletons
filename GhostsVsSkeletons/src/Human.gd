class_name Human
extends GroundedActor

var converted = false

onready var ghost = get_parent().get_parent().get_node("GhostPlayer")
onready var skeleton = get_parent().get_parent().get_node("SkeletonPlayer")

func _ready():
	direction.x = 1 if randf() > 0.5 else -1
	Global.total_humans += 1


func _physics_process(delta):
	# If they both have sodas go to the closer one
	if ghost.soda && skeleton.soda:
		if position.distance_to(ghost.position) < position.distance_to(skeleton.position):
			if abs(ghost.position.y - position.y) < 200:
				direction.x = 1 if ghost.position.x > position.x else -1
		else:
			if abs(skeleton.position.y - position.y) < 200:
				direction.x = 1 if skeleton.position.x > position.x else -1
	# Only humans on the same floor approach
	elif ghost.soda && abs(ghost.position.y - position.y) < 200:
		direction.x = 1 if ghost.position.x > position.x else -1
	elif skeleton.soda && abs(skeleton.position.y - position.y) < 200:
		direction.x = 1 if skeleton.position.x > position.x else -1
	
	velocity.x = direction.x * speed.x
	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, true, 4, 0.9, false)
	
	if direction.x > 0:
		$Sprite.scale.x = -1
	elif direction.x < 0:
		$Sprite.scale.x = 1


func skeletonify():
	if !converted:
		converted = true
		$AnimationPlayer.play("skeleton")
		Global.skeleton_count += 1
		set_collision_layer_bit(3, false)


func ghostify():
	if !converted:
		converted = true
		$AnimationPlayer.play("ghost")
		Global.ghost_count += 1
		set_collision_layer_bit(3, false)


func _on_Timer_timeout():
	direction.x = -direction.x
	$Timer.start(randf())

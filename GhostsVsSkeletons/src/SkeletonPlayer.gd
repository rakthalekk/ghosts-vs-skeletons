class_name SkeletonPlayer
extends GroundedActor

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	get_direction()
	
	var is_jump_interrupted = Input.is_action_just_released("skeleton_jump") and velocity.y < 0.0
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	
	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, true, 4, 0.9, false)


func get_direction():
	direction = Vector2(Input.get_action_strength("skeleton_move_right") - Input.get_action_strength("skeleton_move_left"), 
		-1 if (is_on_floor()) and Input.is_action_just_pressed("skeleton_jump") else 0)


# Takes the player's current velocity and applies movement speed and direction
func calculate_move_velocity(
		linear_velocity,
		direction,
		speed,
		is_jump_interrupted
	):
	var v = linear_velocity
	v.x = speed.x * direction.x
	if direction.y != 0.0:
		v.y = speed.y * direction.y
	if is_jump_interrupted:
		v.y *= 0.5
	return v

func get_holy_water():
	var ghost = get_parent().get_node("GhostPlayer")
	ghost.speed = Vector2(100, 100)
	$Timer.start(5)

func _on_Timer_timeout():
	var ghost = get_parent().get_node("GhostPlayer")
	ghost.speed = Vector2(200, 200)

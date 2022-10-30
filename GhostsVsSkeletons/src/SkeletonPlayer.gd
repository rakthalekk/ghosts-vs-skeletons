class_name SkeletonPlayer
extends GroundedActor

const BONEPROJECTILE = preload("res://src/BoneProjectile.tscn")

var skeleton_is_kill = false


func _physics_process(delta):
	get_direction()
	if !skeleton_is_kill:
		get_input()
	else:
		direction = Vector2(0, 0)
	
	var is_jump_interrupted = Input.is_action_just_released("skeleton_jump") and velocity.y < 0.0
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	
	snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, true, 4, 0.9, false)

	if !skeleton_is_kill:
		if !is_on_floor() && direction.x != 0:
			$AnimationPlayer.play("jumping")
		elif direction.x != 0:
			$AnimationPlayer.play("moving")
		else:
			$AnimationPlayer.play("idle")

		if direction.x > 0:
			$Sprite.scale.x = 1
		elif direction.x < 0:
			$Sprite.scale.x = -1


func get_input():
	if Input.is_action_just_pressed("skeleton_fall_through"):
		set_collision_mask_bit(4, false)
	if Input.is_action_just_released("skeleton_fall_through"):
		set_collision_mask_bit(4, true)
	if Input.is_action_just_pressed("skeleton_kill"):
		$AnimationPlayer.play("kill")
		skeleton_is_kill = true
		if $RangedUpgradeDuration.time_left > 0:
			var bone = BONEPROJECTILE.instance()
			bone.global_position = global_position
			bone.direction.x = $Sprite.scale.x
			get_parent().add_child(bone)


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
	if $SpeedPenalty.time_left > 0:
		v.x *= 0.5
	return v


func inflict_speed_penalty():
	$SpeedPenalty.start($SpeedPenalty.time_left + Global.SPEED_PENALTY_DURATION) # Adds 15 seconds of slowing 


func when_skeleton_is_no_longer_kill():
	skeleton_is_kill = false


func _on_KillZone_body_entered(body):
	body.skeletonify()
	set_collision_mask_bit(4, true)


func slow_other_player():
	var ghost = get_parent().get_node("GhostPlayer")
	ghost.inflict_speed_penalty()


func get_ranged_upgrade():
	$RangedUpgradeDuration.start($RangedUpgradeDuration.time_left + Global.RANGED_UPGRADE_DURATION)


func get_aoe_upgrade():
	pass

class_name GhostPlayer
extends KinematicBody2D

export(Vector2) var speed = Vector2(300, 300)

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

var ghost_is_kill = false
var interacting = false


func _physics_process(delta):
	get_direction()
	if !ghost_is_kill:
		get_input()
	else:
		direction = Vector2(0, 0)
	
	velocity = direction * speed
	
	if $SpeedPenalty.time_left > 0:
		velocity *= 0.5

	velocity = move_and_slide(velocity)

	if !ghost_is_kill && !interacting:
		if direction.y < 0 && direction.x == 0:
			$AnimationPlayer.play("move_up")
		elif direction.y > 0 && direction.x == 0:
			$AnimationPlayer.play("move_down")
		elif direction.y < 0:
			$AnimationPlayer.play("move_up_left")
		elif direction.y > 0:
			$AnimationPlayer.play("move_down_left")
		elif direction.x != 0:
			$AnimationPlayer.play("move_left")
		else:
			$AnimationPlayer.play("idle")
		
		if direction.x < 0:
			$Sprite.scale.x = 1
		elif direction.x > 0:
			$Sprite.scale.x = -1


func get_direction():
	direction = Vector2(Input.get_action_strength("ghost_move_right") - Input.get_action_strength("ghost_move_left"),
		Input.get_action_strength("ghost_move_down") - Input.get_action_strength("ghost_move_up")).normalized()


func get_input():
	if Input.is_action_just_pressed("ghost_kill"):
		$AnimationPlayer.play("kill")
		ghost_is_kill = true
	if Input.is_action_just_pressed("ghost_interact"):
		$AnimationPlayer.play("interact")
		interacting = true


func inflict_speed_penalty():
	$SpeedPenalty.start($SpeedPenalty.time_left + 15) # Adds 15 seconds of slowing 


func when_ghost_is_no_longer_kill():
	ghost_is_kill = false
	interacting = false


func _on_KillZone_body_entered(body):
	body.ghostify()


func _on_InteractZone_area_entered(area):
	area.activate()


func get_cross():
	var skeleton = get_parent().get_node("SkeletonPlayer")
	skeleton.inflict_speed_penalty()


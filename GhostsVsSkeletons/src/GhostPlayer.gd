extends KinematicBody2D


export(Vector2) var speed = Vector2(200, 200)

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

var ghost_is_kill = false
var interacting = false


func _physics_process(delta):
	get_direction()
	get_input()
	
	velocity = direction * speed
	
	velocity = move_and_slide(velocity)
	
	if !ghost_is_kill && !interacting:
		if direction.y < 0:
			$AnimationPlayer.play("move_up_right")
		elif direction.y > 0:
			$AnimationPlayer.play("move_down_right")
		elif direction.x != 0:
			$AnimationPlayer.play("moving")
		else:
			$AnimationPlayer.play("idle")
		
		if $AnimationPlayer.current_animation == "move_up_right" || $AnimationPlayer.current_animation == "move_down_right":
			if direction.x > 0:
				$Sprite.scale.x = -1
			elif direction.x < 0:
				$Sprite.scale.x = 1
		elif direction.x > 0:
			$Sprite.scale.x = 1
		elif direction.x < 0:
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


func when_ghost_is_no_longer_kill():
	ghost_is_kill = false
	interacting = false


func _on_KillZone_body_entered(body):
	body.ghostify()


func _on_InteractZone_area_entered(area):
	area.activate()

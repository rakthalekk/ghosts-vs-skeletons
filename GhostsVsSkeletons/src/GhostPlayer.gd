extends KinematicBody2D


export(Vector2) var speed = Vector2(200, 200)

var direction = Vector2.ZERO
var velocity = Vector2.ZERO


func _physics_process(delta):
	get_direction()
	
	velocity = direction * speed
	
	velocity = move_and_slide(velocity)
	
	if direction.length() != 0:
		$AnimationPlayer.play("moving")
	else:
		$AnimationPlayer.play("idle")
	
	if direction.x > 0:
		$Sprite.scale.x = 1
	elif direction.x < 0:
		$Sprite.scale.x = -1


func get_direction():
	direction = Vector2(Input.get_action_strength("ghost_move_right") - Input.get_action_strength("ghost_move_left"), 
		Input.get_action_strength("ghost_move_down") - Input.get_action_strength("ghost_move_up")).normalized()

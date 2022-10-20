extends GroundedActor


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	direction.x = 1


func _physics_process(delta):
	velocity.x = direction.x * speed.x
	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, true, 4, 0.9, false)
	
	if direction.x > 0:
		$Sprite.scale.x = 1
	elif direction.x < 0:
		$Sprite.scale.x = -1


func _on_Timer_timeout():
	direction.x = -direction.x
	$Timer.start(randf())

extends Area2D

export(int) var speed = 10

var direction = Vector2.ZERO
var arcfire = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if arcfire && direction.x < 0:
		$AnimationPlayer.play("arc_left")
	elif arcfire:
		$AnimationPlayer.play("arc_right")
	elif direction.x < 0:
		$AnimationPlayer.play("spin_left")


func _process(delta):
	position += direction * speed


func _on_OrbProjectile_body_entered(body):
	if body is Human:
		body.ghostify()
	queue_free()


func _on_DisappearTimer_timeout():
	queue_free()

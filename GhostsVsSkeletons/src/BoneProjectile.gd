extends Area2D

export(int) var speed = 10

var direction = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	if direction.x < 0:
		$AnimationPlayer.play("spin_left")


func _process(delta):
	position += direction * speed


func _on_BoneProjectile_body_entered(body):
	if body is Human:
		body.skeletonify()
	queue_free()


func _on_DisappearTimer_timeout():
	queue_free()

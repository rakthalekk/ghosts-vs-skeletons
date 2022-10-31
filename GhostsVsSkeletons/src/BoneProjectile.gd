extends Area2D

export(int) var speed = 1000

var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var arcfire = false

onready var g = ProjectSettings.get("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	if arcfire:
		velocity.y = -1000
		scale = Vector2(2, 2)
	if direction.x < 0:
		$AnimationPlayer.play("spin_left")


func _process(delta):
	if !arcfire:
		velocity = direction * speed
	else:
		velocity.x = direction.x * 400
		velocity.y += g * delta
	position += velocity * delta


func _on_BoneProjectile_body_entered(body):
	if body is Human:
		body.skeletonify()
	queue_free()


func _on_DisappearTimer_timeout():
	queue_free()

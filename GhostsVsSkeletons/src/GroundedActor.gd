class_name GroundedActor
extends KinematicBody2D

const FLOOR_NORMAL = Vector2.UP
const FLOOR_DETECT_DISTANCE = 30.0


export(Vector2) var speed = Vector2(500, 1100)

var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")

func _physics_process(delta):
	velocity.y += gravity * delta

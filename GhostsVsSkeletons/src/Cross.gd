class_name Cross
extends Area2D
#Pickup that slows down skeleton when picked up by ghost

func _on_Cross_body_entered(body):
	body.get_cross()
	queue_free()

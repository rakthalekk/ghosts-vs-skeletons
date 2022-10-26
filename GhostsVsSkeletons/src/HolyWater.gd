class_name HolyWater
extends Area2D
#Pickup that slows down ghost when picked up by skeleton



func _on_HolyWater_body_entered(body):
	body.get_holy_water()
	queue_free()

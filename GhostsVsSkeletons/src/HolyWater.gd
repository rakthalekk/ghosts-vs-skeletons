class_name HolyWater
extends PowerUp
#Pickup that slows down ghost when picked up by skeleton

func _on_HolyWater_body_entered(body):
	body.get_holy_water()
	delete_self()


func _on_DisappearTimer_timeout():
	delete_self()

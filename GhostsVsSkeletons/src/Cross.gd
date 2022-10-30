class_name Cross
extends PowerUp
#Pickup that slows down skeleton when picked up by ghost

func _on_Cross_body_entered(body):
	body.get_cross()
	delete_self()


func _on_DisappearTimer_timeout():
	delete_self()

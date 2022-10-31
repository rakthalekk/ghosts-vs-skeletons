class_name CVPowerup
extends PowerUp


func _on_CVPowerup_body_entered(body):
	body.get_cv()
	delete_self()


func _on_DisappearTimer_timeout():
	delete_self()

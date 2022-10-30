class_name SlowPowerup
extends PowerUp


func _on_SlowPowerup_body_entered(body):
	body.slow_other_player()
	delete_self()


func _on_DisappearTimer_timeout():
	delete_self()

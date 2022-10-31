class_name RangedPowerup
extends PowerUp


func _on_RangedPowerup_body_entered(body):
	body.get_ranged_upgrade()
	delete_self()


func _on_DisappearTimer_timeout():
	delete_self()

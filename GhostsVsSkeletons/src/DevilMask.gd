class_name DevilMask
extends PowerUp


func _on_DevilMask_body_entered(body):
	body.get_mask()
	delete_self()


func _on_DisappearTimer_timeout():
	delete_self()

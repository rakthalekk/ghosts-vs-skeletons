class_name FreeSodaFromGoldenDragon
extends PowerUp


func _on_FreeSodaFromGoldenDragon_body_entered(body):
	body.get_soda()
	delete_self()


func _on_DisappearTimer_timeout():
	delete_self()

extends Area2D

var user = "Skeleton"


func _on_AOEConvert_body_entered(body):
	if user == "Skeleton":
		body.skeletonify()
	else:
		body.ghostify()


func _on_DisappearTimer_timeout():
	queue_free()

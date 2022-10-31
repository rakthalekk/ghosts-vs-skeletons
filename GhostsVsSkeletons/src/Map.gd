extends Node2D

signal update_minimap_stairs
signal create_human_icon
signal create_powerup_icon(powerup)
signal remove_powerup_icon(powerup)
signal fade_out_ghost
signal turn_off_corrupted_music


func _on_WesternEntrance_body_entered(body):
	$Music.stop()
	emit_signal("fade_out_ghost")
	call_deferred("disable_western_entrance")
	$Foreground.set_cellv(Vector2(-10, 35), 1)
	$Foreground.set_cellv(Vector2(-10, 36), 1)


func disable_western_entrance():
	$WesternEntrance.get_node("CollisionShape2D").disabled = true


func _on_WesternEntrance2_body_entered(body):
	$AnimationPlayer.play("How Dare You")
	$Foreground.set_cellv(Vector2(-52, 35), 1)
	$Foreground.set_cellv(Vector2(-52, 36), 1)


func turn_off_the_dang_ground():
	emit_signal("turn_off_corrupted_music")
	$Foreground.set_cellv(Vector2(-61, 41), -1)
	$Foreground.set_cellv(Vector2(-60, 41), -1)
	$Foreground.set_cellv(Vector2(-59, 41), -1)
	$Foreground.set_cellv(Vector2(-58, 41), -1)
	$Foreground.set_cellv(Vector2(-57, 41), -1)
	$Foreground.set_cellv(Vector2(-56, 41), -1)
	$Foreground.set_cellv(Vector2(-55, 41), -1)
	$Foreground.set_cellv(Vector2(-54, 41), -1)
	$Foreground.set_cellv(Vector2(-53, 41), -1)


func _on_OofCollider_body_entered(body):
	body.oof()

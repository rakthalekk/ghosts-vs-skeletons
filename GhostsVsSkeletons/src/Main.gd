# This script is from the GDQuest Tutorial How to do a Split-Screen Co-op in Godot
# CC-By 4.0 - GDQuest and contributors

extends Node2D

onready var players := {
	"1": {
		viewport = $HBoxContainer/ViewportContainer/Viewport,
		camera = $HBoxContainer/ViewportContainer/Viewport/Camera2D,
		player = $HBoxContainer/ViewportContainer/Viewport/Map/SkeletonPlayer
	},
	"2": {
		viewport = $HBoxContainer/ViewportContainer2/Viewport,
		camera = $HBoxContainer/ViewportContainer2/Viewport/Camera2D,
		player = $HBoxContainer/ViewportContainer/Viewport/Map/GhostPlayer
	}
}


func _ready():
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	for node in players.values():
		var remote_transform = RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		node.player.add_child(remote_transform)


func _process(delta):
	$HumanCount.text = "Human Count: " + str(Global.total_humans)
	$GhostCount.text = "Ghost Count: " + str(Global.ghost_count)
	$SkeletonCount.text = "Skeleton Count: " + str(Global.skeleton_count)
	$TimerCount.text = "Time Left: " + str(stepify($CountdownTimer.time_left, 1))


func _on_Map_fade_out_ghost():
	$AnimationPlayer.play("fade_out_ghost")


func play_corrupted_music():
	$CorruptedMusic.play()


func _on_Map_turn_off_corrupted_music():
	$CorruptedMusic.stop()


func _on_CountdownTimer_timeout():
	Global.winner = "skeleton" if Global.skeleton_count > Global.ghost_count else "ghost"
	Global.total_humans = 0
	Global.skeleton_count = 0
	Global.ghost_count = 0
	get_tree().change_scene("res://src/GameOverScreen.tscn")
	pass # Replace with function body.

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

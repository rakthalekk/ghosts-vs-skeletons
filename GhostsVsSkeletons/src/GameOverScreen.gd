extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.winner == "ghost":
		$WinnerSprite.texture = load("res://assets/Standing Ghost.png")
		# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayAgain_pressed():
	get_tree().change_scene("res://src/Main.tscn")


func _on_MainMenu_pressed():
	get_tree().change_scene("res://src/Menu.tscn")
	pass # Replace with function body.

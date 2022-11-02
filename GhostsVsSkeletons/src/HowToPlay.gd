extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ReturnButton.grab_focus()

func _on_ReturnButton_pressed():
	hide()
	get_parent().get_node("MainMenu").show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

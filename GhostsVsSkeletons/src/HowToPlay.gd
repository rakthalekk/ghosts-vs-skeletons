extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_ReturnButton_pressed():
	hide()
	get_parent().get_node("MainMenu").show()
	get_parent().get_node("MainMenu/OptionsButton").grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func grab_button():
	$ReturnButton.grab_focus()

extends ColorRect

func _on_Continue_pressed():
	Global.goto_scene("res://src/Level/areas/1/Roof0.tscn")

func _on_Levels_pressed():
	Global.goto_levelchooser()


func _on_Options_pressed():
	$"Options".show()
	pass # Replace with function body.

extends Node

func _ready():
	get_tree().paused = false
	OS.window_fullscreen = Global.getOption("fullscreen")
func _on_Continue_pressed():
	Global.goto_scene("res://src/Level/areas/1/Roof0.tscn")

func _on_Levels_pressed():
	Global.goto_levelchooser()


func _on_Options_pressed():
	$"Options".show()
	pass # Replace with function body.


func _on_Quit_pressed():
	Global.save_savefile()
	get_tree().quit()

extends Node

func _ready():
	get_tree().paused = false
	OS.window_fullscreen = Global.getOption("fullscreen")
func _on_Continue_pressed():
	Global.goto_scene("res://src/Level/areas/1/Roof0.tscn")

func _on_Levels_pressed():
	Global.goto_levelchooser()

func _on_Options_pressed():
	($CanvasLayer2/Options as TextureRect).show()

func _on_Quit_pressed():
	Global.save_savefile()
	get_tree().quit()

func _unhandled_input(event):
	if Input.is_action_pressed("ui_cancel") and $CanvasLayer2/Options.visible:
		get_tree().set_input_as_handled()
		$CanvasLayer2/Options.hide()

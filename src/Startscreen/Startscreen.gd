extends Node

func _on_Continue_pressed():
	Global.goto_scene("res://src/Level/areas/1/Roof0.tscn")

func _on_Levels_pressed():
	Global.goto_levelchooser()

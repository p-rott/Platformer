extends Node

onready var _pause_menu = $InterfaceLayer/PauseMenu

func _init():
	OS.min_window_size = OS.window_size
	OS.max_window_size = OS.get_screen_size()

func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("toggle_pause"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		get_tree().set_input_as_handled()

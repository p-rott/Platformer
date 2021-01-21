extends Control

onready var resume_button = $VBoxContainer/ResumeButton
func _ready():
	visible = false

func close():
	visible = false

func open():
	visible = true
	resume_button.grab_focus()

func _on_ResumeButton_pressed():
	get_tree().paused = false
	visible = false

func _on_QuitButton_pressed():
	get_tree().quit()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			open()
		else:
			close()
		get_tree().set_input_as_handled()




extends Control

onready var resumeButton = $VBoxContainer/ResumeButton

func _on_ResumeButton_pressed():
	get_tree().paused = false
	get_parent().get_parent().nextLevel()

func _on_QuitButton_pressed():
	get_tree().paused = false
	get_parent().get_parent().gotToMainMenu()

func _ready():
	visible = false

func close():
	visible = false

func open():
	visible = true
	get_tree().paused = true

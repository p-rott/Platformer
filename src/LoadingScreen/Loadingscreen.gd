extends Control
class_name LoadingscreenScript
onready var progressBar : ProgressBar = get_node("MarginContainer/VBoxContainer/ProgressBar")

func _ready():
	pass

func set_progress(progress):
	progressBar.set_value(progress*100)


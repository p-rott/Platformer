extends Control

onready var resumeButton = $VBoxContainer/ResumeButton
onready var deathcount = $VBoxContainer/HBoxDeaths/LabelDeaths
onready var bestTime = $VBoxContainer/HBoxBestTime/LabelBestTime
onready var currentTime = $VBoxContainer/HBoCurrentTime/LabelCurrentTime
var levelName

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

func open(currenLevelTime):
	deathcount.text = str(Global.get_level_deaths(levelName))
	bestTime.text = str(Global.get_level_time(levelName))
	currentTime.text = str(currenLevelTime)
	visible = true
	get_tree().paused = true

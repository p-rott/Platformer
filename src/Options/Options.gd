extends ColorRect

func _ready():
	$"MarginContainer/VBoxContainer/MasterVolume".value = Global.getOption("masterVolume")
	$"MarginContainer/VBoxContainer/MusicVolume".value = Global.getOption("musicVolume")
	$"MarginContainer/VBoxContainer/SFXVolume".value = Global.getOption("sfxVolume")
	$"MarginContainer/VBoxContainer/Grayscale".pressed = Global.getOption("grayscale")
	$"MarginContainer/VBoxContainer/ChrAbeAmount".value = Global.getOption("chromaticAberrationAmount")
	$MarginContainer/VBoxContainer/ChromaticAberration.pressed = Global.getOption("chromaticAberration")
	$MarginContainer/VBoxContainer/Fullscreen.pressed = Global.getOption("fullscreen")
	
func masterVolume_changed(value):
	Global.set_masterVolume(value)
	
func musicVolume_changed(value):
	Global.set_musicVolume(value)
	
func sfxVolume_changed(value):
	Global.set_sfxVolume(value)
	
func grayscale_changed(value):
	Global.saveOption("grayscale", value)

func chromaticAberration_changed(value):
	Global.saveOption("chromaticAberration", value)
	
func chromaticAberrationAmount_changed(value):
	Global.saveOption("chromaticAberrationAmount", value)	


func _on_Fullscreen_toggled(button_pressed):
	Global.saveOption("fullscreen", button_pressed)
	OS.window_fullscreen = button_pressed

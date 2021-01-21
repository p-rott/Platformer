extends Node2D

func _ready():
	$CanvasLayer2/StartscreenLevel.usedAsVictoryScreen = true

func _on_Continue_pressed():
	Global.goto_startscreen()

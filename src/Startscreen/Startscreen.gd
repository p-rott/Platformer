extends ColorRect

func _ready():
	pass


# add code here to continue last level
func _on_Continue_pressed():
	Global.goto_scene("res://src/Level/areas/1/Level1.tscn")


func _on_Levels_pressed():
	Global.goto_levelchooser()

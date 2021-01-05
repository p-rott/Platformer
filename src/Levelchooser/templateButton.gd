extends Button
var levelpath
func _ready():
	pass


func _on_pressed():
	#print(levelpath)
	Global.goto_scene(levelpath)
	pass # Replace with function body.

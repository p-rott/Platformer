extends ColorRect
var worlds : Dictionary = {}

func _ready():
	dir_worlds("res://src/Level/areas")

func _on_Back_pressed():
	Global.goto_startscreen()

func dir_worlds(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if not (file_name == "." or file_name ==".."):
					var world = $"Template Gridbox".duplicate()
					world.set_name("World "+file_name)
					worlds[file_name] = world
					$"MarginBox/VBoxContainer/TabContainer".add_child(world)
					dir_levels(path,file_name)
			else:
				pass
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func dir_levels(path, world):
	var dir = Directory.new()
	var levelCount = 1
	if dir.open(path+"/"+world) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		print(file_name)
		while file_name != "":
			if dir.current_is_dir():
				if not (file_name == "." or file_name ==".."):
					pass
			elif file_name.ends_with(".tscn"):
				var level = $"Template Button".duplicate() as Button
				level.levelpath = path+"/"+world+"/"+file_name
				level.set_text(String(levelCount))
				levelCount +=1
				level.show()
				(worlds[world]).add_child(level)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

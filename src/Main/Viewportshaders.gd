tool
extends CanvasLayer


export(int,"Red", "Green", "Blue") var colorKey = 1 setget setColorKey


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		for _i in self.get_children(): #hides all shaders in Editor
			_i.hide()
	else:
		for _i in self.get_children(): #hides all shaders in Editor
			_i.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Sets the color which is passed through the grayscale filter
func setColorKey(newVal): 
	print()
	if newVal == 0:
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_red", true)
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_green", false)
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_blue", false)
		pass
	elif newVal == 1:
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_red", false)
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_green", true)
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_blue", false)
		pass
	else:
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_red", false)
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_green", false)
		$"BackBufferCopy/GrayscaleColor".get_material().set_shader_param("ignore_pure_blue", true)
		pass
	
	colorKey = newVal
	
	pass

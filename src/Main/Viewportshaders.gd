tool
extends CanvasLayer


export(int,"Red", "Green", "Blue") var colorKey = 0 setget setColorKey

var grayscale
var chromaticAberration
var chromaticAberrationAmount
onready var GrayscaleColor = $"GrayscaleBuffer/GrayscaleColor"
onready var ChromaticAberration = $"ChromaticAberrationBuffer/ChromaticAberration"
# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Engine.editor_hint:
		for _i in self.get_children(): #hides all shaders in Editor
			_i.hide()
	else:
		for _i in self.get_children(): #hides all shaders in Editor
			grayscale = Global.getOption("grayscale")
			chromaticAberration = Global.getOption("chromaticAberration")
			chromaticAberrationAmount = Global.getOption("chromaticAberrationAmount")
			_i.show()
		if grayscale: 
			GrayscaleColor.show() 
		else: 
			GrayscaleColor.hide()
		if chromaticAberration: 
			ChromaticAberration.show() 
		else: 
			ChromaticAberration.hide()
		ChromaticAberration.get_material().set_shader_param("amount", chromaticAberrationAmount /100)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not Engine.editor_hint:
		if grayscale != Global.getOption("grayscale"):
			grayscale = Global.getOption("grayscale")
			if grayscale: 
				GrayscaleColor.show() 
			else: 
				GrayscaleColor.hide()
		if chromaticAberration != Global.getOption("chromaticAberration"):
			chromaticAberration = Global.getOption("chromaticAberration")
			if chromaticAberration: 
				ChromaticAberration.show() 
			else: 
				ChromaticAberration.hide()
		if chromaticAberrationAmount != Global.getOption("chromaticAberrationAmount"):
			chromaticAberrationAmount = Global.getOption("chromaticAberrationAmount")
			ChromaticAberration.get_material().set_shader_param("amount", chromaticAberrationAmount /100)
#	pass

# Sets the color which is passed through the grayscale filter
func setColorKey(newVal): 
	if not Engine.editor_hint:
		if newVal == 0:
			GrayscaleColor.get_material().set_shader_param("ignore_pure_red", true)
			GrayscaleColor.get_material().set_shader_param("ignore_pure_green", false)
			GrayscaleColor.get_material().set_shader_param("ignore_pure_blue", false)
			pass
		elif newVal == 1:
			GrayscaleColor.get_material().set_shader_param("ignore_pure_red", false)
			GrayscaleColor.get_material().set_shader_param("ignore_pure_green", true)
			GrayscaleColor.get_material().set_shader_param("ignore_pure_blue", false)
			pass
		else:
			GrayscaleColor.get_material().set_shader_param("ignore_pure_red", false)
			GrayscaleColor.get_material().set_shader_param("ignore_pure_green", false)
			GrayscaleColor.get_material().set_shader_param("ignore_pure_blue", true)
			pass
		
		colorKey = newVal
		
		pass

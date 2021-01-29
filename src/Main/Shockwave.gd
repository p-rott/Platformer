extends Node2D

onready var ShockwaveShader = $ShockwaveShader
export var size := 100.0
func _ready():
	ShockwaveShader.scale = Vector2(size/64,size/64)
	pass

func setup(globalPosition: Vector2) -> void:
	global_position = globalPosition
	pass

func setShaderParam(value: float) -> void:
	ShockwaveShader.get_material().set_shader_param("size", value)

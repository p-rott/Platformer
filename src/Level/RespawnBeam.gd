class_name RespawnBeam

extends Node2D

onready var beam : Line2D = $Beam
onready var beamParticles : Particles2D = $"Beam Particles"
onready var beamTween : Tween = $"Beam Tween"

var startPoint : Vector2
var spawnPoint : Vector2
var time : float
var color : Color

func _ready():
	var directionVector = spawnPoint - startPoint
	beam.points[1].x = directionVector.length()
	rotation = directionVector.angle()
	beamTween.interpolate_property(beam, "width", 0, 10, time/2)
	beamTween.interpolate_property(beam, "width", 10, 0, time/2, 0,2, time/2)
	beamTween.interpolate_property(self, "modulate", self.modulate, Color(1,1,1,0), 0.25, 0,2, time)
	beamTween.interpolate_callback(self, time+.25, "queue_free")
	beamParticles.position.x = directionVector.length() * .5
	beamParticles.process_material.emission_box_extents.x = directionVector.length() * .5
	beamTween.start()
	beamParticles.emitting = true
	pass

func setup(startPoint : Vector2, spawnPoint : Vector2, color : Color, time : float) -> void:
	global_position = startPoint
	#modulate = color
	self.startPoint = startPoint
	self.spawnPoint = spawnPoint
	self.time = time


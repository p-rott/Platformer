extends RayCast2D
class_name LaserBeam
var isCasting := false setget setIsCasting
onready var Line : Line2D= $Line
onready var Tween : = $Tween
onready var CastingParticle : = $CastingParticle
onready var CollisionParticle : = $CollisionParticle
onready var BeamParticle : = $BeamParticle
func _ready():
	set_physics_process(false)
	Line.points[1] = Vector2.ZERO
func setup(maxLength : float, color : Color) -> void:
	self.modulate = color
	cast_to.x = maxLength 
	
func _physics_process(delta):
	var castPoint := cast_to
	force_raycast_update()
	CollisionParticle.emitting = is_colliding()
	if is_colliding():
		castPoint = to_local(get_collision_point())
		CollisionParticle.global_rotation =  get_collision_normal().angle()
		CollisionParticle.position = castPoint
	Line.points[1] = castPoint
	BeamParticle.position = castPoint * .5
	BeamParticle.process_material.emission_box_extents.x = castPoint.length() * .5

func setIsCasting(cast : bool) -> void:
	isCasting = cast
	CastingParticle.emitting = isCasting
	BeamParticle.emitting = isCasting
	if isCasting:
		appear()
	else:
		CollisionParticle.emitting = false
		disappear()
	set_physics_process(isCasting)
	pass
	
func appear() -> void:
	Tween.stop_all()
	Tween.interpolate_property(Line, "width", 0, 5.0, .2)
	Tween.start()
	
func disappear() -> void:
	Tween.stop_all()
	Tween.interpolate_property(Line, "width", 5.0,0, .1)
	Tween.start()
	


func playerHitTrap(body):
	pass # Replace with function body.

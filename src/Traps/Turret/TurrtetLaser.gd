extends Turret
class_name TurretLaser

export var maxLaserDistance = 1000
export var color : Color = Color(1, 1, 1)
var laserBeam : LaserBeam
func _ready():
	laserBeam = turretShot.instance()
	laserBeam.setup(maxLaserDistance, color)
	laserBeam.position = Vector2(10.0,0)
	TurretHead.add_child(laserBeam)

func shoot(normal:Vector2) -> void:
	if(!laserBeam.isCasting):
		laserBeam.setIsCasting(true)
	pass
func bodyExited(body:Node)->void:
	if(body.is_in_group("Player")):
		laserBeam.setIsCasting(false)
		player = null
	


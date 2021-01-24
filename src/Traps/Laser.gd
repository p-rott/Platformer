class_name Laser
extends Trap

var active = false
onready var LaserLight : Light2D= $Sprite/LaserLight
func _ready():
	disableLaser()

func _process(delta):
	if active:
		$Sprite.modulate = Color(rand_range(0.0, 1.0),rand_range(0.0, 1.0),rand_range(0.0, 1.0),1)

func setLaserLength(length):
	var factor = (length + 22) / 32
	$Sprite.scale.x = factor
	$CollisionShape2D.scale.x = factor

func setPositionAndTarget(pos, target):
	var dist = pos.distance_to(target)
	position = pos + (pos + target) / 2
	var factor = abs(dist) / 32
	scale.x = factor

func enableLaserWarning():
	$Sprite.visible = true
	$Sprite.modulate = Color(1,1,1,0.3)

func enableLaser():
	active = true
	LaserLight.enabled = true
	$Sprite.visible = true
	$Sprite.modulate = Color(1,1,1,1)
	$CollisionShape2D.disabled = false

func disableLaser():
	active = false
	LaserLight.enabled = true
	$Sprite.visible = false
	$CollisionShape2D.disabled = true


func _on_Laser_body_entered(body):
		playerHitTrap(body)

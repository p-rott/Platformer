extends Level

export var usedAsVictoryScreen = false

func _ready():
	._ready()
	$Player/Sprite.flip_h = true
	if usedAsVictoryScreen:
		$Traps/LaserEmitter.visible = false

func letPlayerJump():
	$Player.jump()

func startAnimationLoop():
	if !usedAsVictoryScreen:
		$ControlNodes/PlayerSpawn.position = Vector2(230, 30)
		$Traps/LaserEmitter.firstDelay = 0
		$Traps/LaserEmitter.updateLaserReach()
		$Traps/LaserEmitter.setTimersAndStart()
		$AnimationLoop.play("jump_over_laser")
		$AnimationPlayer.play("police_ship")
	else:
		$Traps/LaserEmitter.visible = false
		$AnimationPlayer.play("victory")

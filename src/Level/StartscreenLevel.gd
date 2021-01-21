extends Level

func letPlayerJump():
	$Player.jump()

func startAnimationLoop():
	$ControlNodes/PlayerSpawn.position = Vector2(230, 30)
	$Traps/LaserEmitter.firstDelay = 0
	$Traps/LaserEmitter.updateLaserReach()
	$Traps/LaserEmitter.setTimersAndStart()
	$AnimationLoop.play("jump_over_laser")
	$AnimationPlayer.play("police_ship")

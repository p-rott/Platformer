class_name FallingPlatformWithLaserNotifier
extends FallingPlatform


func fall():
	.fall()
	var parent = get_node("../../Traps")
	for c in parent.get_children():
		if c is LaserEmitterGroup or c is LaserEmitter:
			c.updateLaserReach()

extends Node2D
class_name LaserEmitterGroup
#Add laser emitters as children to have them be synchronized
#Use two groups, one with delay, to have interchanging lasers

export var laserCooldown = 5.0
export var laserActive = 1.0
export var firstDelay = 0.0

func _ready():
	for c in get_children():
		c.laserCooldown = laserCooldown
		c.laserActive = laserActive
		c.firstDelay = firstDelay
		c.setTimersAndStart()

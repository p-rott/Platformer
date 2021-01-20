class_name LaserEmitterGroup
extends Node2D

#Add laser emitters as children to have them be synchronized
#Use two groups, one with delay, to have interchanging lasers

export var laserCooldown = 5.0
export var laserActive = 1.0
export var laserWarning = 1.0
export var firstDelay = 0.0

func _ready():
	setTimersAndStart()

func setTimersAndStart():
	for c in get_children():
		if c is LaserEmitter:
			c.laserCooldown = laserCooldown
			c.laserActive = laserActive
			c.firstDelay = firstDelay
			c.laserWarning = laserWarning
			c.setTimersAndStart()

func updateLaserReach():
	for c in get_children():
		if c is LaserEmitter:
			c.updateLaserReach()

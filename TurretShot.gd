extends "res://src/Traps/Trap.gd"
class_name TurretShot

var movementDirection:= Vector2.ZERO
export var speed := 500.0

func _ready():
	pass

func _process(delta):
	position += movementDirection.normalized() * speed * delta
	
func setup(point_direction: Vector2) ->void:
	movementDirection = point_direction


func _on_TurretShot_body_entered(body):
	if(body.is_in_group("Player")):
		playerHitTrap(body)
		queue_free()
		pass
	elif !body.is_a_parent_of(self):
		queue_free()


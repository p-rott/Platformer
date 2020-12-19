extends StaticBody2D

func _ready():
	name = "Trap" + name
	print(name)

#TODO code for collision in player script:
#	if collision != null and collision.collider.name.begins_with("Trap"):
#		#DIE

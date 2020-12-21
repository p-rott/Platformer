extends Node2D

onready var raycast = $RayCast2D

func getSpawn():
	raycast.force_raycast_update() 
	if raycast.is_colliding():
		return raycast.get_collision_point() + Vector2(0, -20)

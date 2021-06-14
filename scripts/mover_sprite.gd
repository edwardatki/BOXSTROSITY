tool
extends Node2D

func _process(delta):
	self.rotation = -get_parent().move_direction.angle_to(Vector2.UP)
	return

extends KinematicBody2D

const GRID_SIZE = 16.0
const MOVE_SPEED = 150.0

onready var level_manager = get_parent()

var move_root = false
var moving = false
onready var target_position = self.global_position

var grabbed_by = []

func get_touching():
	var touching = []
	
	$RayCast2D.cast_to = Vector2.UP * GRID_SIZE
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		touching.append($RayCast2D.get_collider())
	
	$RayCast2D.cast_to = Vector2.DOWN * GRID_SIZE
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		touching.append($RayCast2D.get_collider())
	
	$RayCast2D.cast_to = Vector2.RIGHT * GRID_SIZE
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		touching.append($RayCast2D.get_collider())
	
	$RayCast2D.cast_to = Vector2.LEFT * GRID_SIZE
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		touching.append($RayCast2D.get_collider())
	
	return touching

func get_pushed(dir):
	$RayCast2D.cast_to = dir * GRID_SIZE
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().is_in_group("pushable"):
			return $RayCast2D.get_collider()
	return null

func can_move(dir):
	$RayCast2D.cast_to = dir * GRID_SIZE
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().is_in_group("pushable"):
			return $RayCast2D.get_collider().can_move(dir)
		else:
			return false
	return true

func move(dir, pusher):
	if self.is_in_group("grabbable"):
		for g in self.grabbed_by:
			if g == pusher:
				continue
			if self.can_move(dir):
				g.move(dir, self)
	
	if self.is_in_group("grabber"):
		for g in self.grabbed:
			if g == pusher:
				continue
			if self.can_move(dir):
				g.move(dir, self)
	
	if can_move(dir):
		var ahead = get_pushed(dir)
		if ahead:
			ahead.move(dir, self)
		level_manager.queue_move(self, dir * GRID_SIZE)
		return true
	return false

func _process(delta):
	for t in get_touching():
		if t.is_in_group("grabber") and t.grabbing:
			if !grabbed_by.has(t):
				grabbed_by.append(t)
		else:
			if grabbed_by.has(t):
				grabbed_by.erase(t)
	for g in grabbed_by:
		if !get_touching().has(g):
			grabbed_by.erase(g)
	
	if !self.is_in_group("mover") and !self.is_in_group("grabber"):
		if grabbed_by.size() > 0:
			$AnimatedSprite.animation = "grabbed"
		else:
			$AnimatedSprite.animation = "default"
		
	
	if moving:
		if (target_position - self.global_position).length() < 1:
			moving = false
			move_root = false
	
	var target_direction = (target_position - self.global_position).normalized()
	var target_distance = (target_position - self.global_position).length()
	self.global_position += target_direction * min(MOVE_SPEED * delta, target_distance)
	
	return

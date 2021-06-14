extends "res://scripts/moveable.gd"

export(String) var grab_action

var grabbing = false
var was_grabbing = false

var grabbed = []

signal grab

func _ready():
	return

func _process(_delta):
	grabbing = Input.is_action_pressed(grab_action)
	if Input.is_action_just_pressed(grab_action):
		emit_signal("grab")
	
	if grabbing:
		for t in get_touching():
			if t.is_in_group("grabbable"):
				if !grabbed.has(t):
					grabbed.append(t)
		for g in grabbed:
			if !get_touching().has(g):
				grabbed.erase(g)
	if !grabbing:
		grabbed.clear()
	
	if grabbing:
		$AnimatedSprite.animation = "grab"
	else:
		$AnimatedSprite.animation = "default"
	
	was_grabbing = grabbing

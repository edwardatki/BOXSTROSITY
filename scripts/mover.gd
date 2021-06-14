extends "res://scripts/moveable.gd"

export(Vector2) var move_direction
export(String) var move_action

signal moved

func _process(_delta):
	var dir = move_direction * float(Input.is_action_just_pressed(move_action))
	
	if dir.length() > 0.0:
		if !moving and level_manager.can_do_moves:
			if self.move(dir, self):
				level_manager.play_move_sound()
			else:
				level_manager.play_fail_sound()
			move_root = true
			level_manager.do_moves()
			emit_signal("moved")
	
	if moving and move_root:
		if grabbed_by.size() > 0:
			$AnimatedSprite.animation = "move_and_grabbed"
		else:
			$AnimatedSprite.animation = "move"
	else:
		if grabbed_by.size() > 0:
			$AnimatedSprite.animation = "grabbed"
		else:
			$AnimatedSprite.animation = "default"
	
	return

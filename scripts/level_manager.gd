extends Node2D

var moves : Dictionary
var can_do_moves = false

var goals = []
var won = false

signal level_complete

func queue_move(node, dir):
	moves[node] = dir

func do_moves():
	if can_do_moves:
		for n in moves.keys():
			n.target_position += moves[n]
			n.moving = true
	moves.clear()

func _ready():
	for c in self.get_children():
		if c.is_in_group("goal"):
			goals.append(c)
	
	return

func play_move_sound():
	if !$MoveAudio.playing:
		$MoveAudio.play()
	return

func play_fail_sound():
	if !$FailAudio.playing:
		$FailAudio.play()
	return

func _process(_delta):
	var win = true
	for g in goals:
		var complete = false
		for b in g.get_overlapping_bodies():
			if b.is_in_group("box"):
				complete = true
		if !complete:
			win = false
	
	if win and !won:
		can_do_moves = false
		won = true
		$WinAudio.play()
		yield($WinAudio, "finished")
		emit_signal("level_complete")
	
	return

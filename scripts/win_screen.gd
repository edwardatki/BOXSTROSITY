extends Node

var can_do_moves = false

signal level_complete

func _ready():
	yield(get_tree().create_timer(5.0), "timeout")
	emit_signal("level_complete")
	return

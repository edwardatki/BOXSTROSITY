extends Node

onready var game_manager = get_tree().get_root().get_node("Root")

var menu_track = preload("res://sounds/Searching for a Body.ogg")
var forest_track = preload("res://sounds/No Worries.ogg")
var desert_track = preload("res://sounds/Ooh! a Fly, wait... It isn\'t.ogg")
var tundra_track = preload("res://sounds/No Destination.ogg")
var win_track = preload("res://sounds/Run As Fast As You Can.ogg")

var current_track

func _ready():
	pass


func _process(_delta):
	var current_level = game_manager.level_index
	
	var target_track
	if current_level == 0:
		target_track = menu_track
	elif current_level <= 5:
		target_track = forest_track
	elif current_level <= 10:
		target_track = desert_track
	elif current_level <= 15:
		target_track = tundra_track
	elif current_level > 15:
		target_track = win_track
	
	if target_track != current_track:
		fade_to_track(target_track)
		current_track = target_track

var toggle = false
func fade_to_track(track):
	if toggle:
		$PlayerA.stream = track
		$PlayerA.play()
		$AnimationPlayer.play("Fade_to_A")
	else:
		$PlayerB.stream = track
		$PlayerB.play()
		$AnimationPlayer.play("Fade_to_B")
	toggle = !toggle
	return

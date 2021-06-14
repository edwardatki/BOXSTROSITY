extends Node

onready var game_manager = get_tree().get_root().get_node("Root")

var can_do_moves = false

signal select_level

var state = 0

func _ready():
	if game_manager.get_progress() > 1:
		$Main/Play/Button.text = "CONTINUE"
	else:
		$Main/Play/Button.text = "START"

func _process(_delta):
	$Main.visible = state == 0
	$LevelSelect.visible = state == 1
	
	return

func play_pressed():
	$ButtonAudio.play()
	yield($ButtonAudio, "finished")
	emit_signal("select_level", game_manager.get_progress())
	return

func level_select_pressed():
	$ButtonAudio.play()
	state = 1
	return

func exit_pressed():
	$ButtonAudio.play()
	get_tree().quit()
	return

func back_pressed():
	$ButtonAudio.play()
	state = 0
	return

func select_level(index):
	print(index)
	$ButtonAudio.play()
	yield($ButtonAudio, "finished")
	emit_signal("select_level", index)
	return

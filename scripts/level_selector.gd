extends AnimatedSprite

export(int) var index = 1

onready var game_manager = get_tree().get_root().get_node("Root")

signal select_level

func _ready():
	$CentreContainer/Button.text = str(index-((index-1)/5)*5)
	return

func _process(delta):
	if game_manager.levels_unlocked[index]:
		self.animation = "default"
		$CentreContainer.visible = true
	else:
		self.animation = "locked"
		$CentreContainer.visible = false
	
	return

func _on_Button_pressed():
	emit_signal("select_level", index)
	return

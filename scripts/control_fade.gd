extends Control

const FADE_SPEED = 5.0
var fading = false

func fade():
	fading = true
	return

func _process(delta):
	if fading:
		self.modulate.a = clamp(self.modulate.a - (FADE_SPEED * delta), 0.0, 1.0)

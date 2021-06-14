extends Button

onready var level = self.get_parent().get_parent().get_parent()
onready var palette = level.get_material().get_shader_param("palette")

var hovered = false
var focused = false

func _process(_delta):
	var img = palette.get_data()
	
	img.lock()
	if self.pressed:
		self.modulate = img.get_pixel(1, 0)
		hovered = false
		focused = false
	elif self.hovered or self.focused:
		self.modulate = img.get_pixel(2, 0)
	else:
		self.modulate = img.get_pixel(3, 0)
	img.unlock()
	
	return

func mouse_entered():
	hovered = true
	return

func mouse_exited():
	hovered = false
	return


func focus_entered():
	focused = true
	return


func focus_exited():
	focused = false
	return

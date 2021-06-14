tool
extends MeshInstance

const SPIN_SPEED = 1.5

func _process(delta):
	rotate(Vector3.UP, SPIN_SPEED * delta)
	rotate(Vector3.RIGHT, SPIN_SPEED * 0.27463 * delta)
	rotate(Vector3.FORWARD, SPIN_SPEED * 0.19832 * delta)

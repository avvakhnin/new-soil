extends MeshInstance3D

@export var rotate_speed = 10.
func _process(delta: float) -> void:
	rotate(Vector3.UP, rotate_speed*delta)

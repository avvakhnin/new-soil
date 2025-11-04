extends MeshInstance3D

@export var speed = 10.
@export var rotate_speed = 1.5
@export var target: Node3D

func _process(delta: float) -> void:
	RotationHelper.rotate_to_target(self, target.position, rotate_speed * delta)
	position += (-basis.z) * speed * delta

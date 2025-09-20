extends Camera3D

const FAR_POSITION: Vector3 = Vector3(0, 5, 5)
const FAR_ROTATION: Vector3 = Vector3(-45, 0, 0)
const CLOSE_POSITION: Vector3 = Vector3(0, 2, 1)
const CLOSE_ROTATION: Vector3 = Vector3(-15, 0, 0)

func _ready() -> void:
	move_far()
	
func move_far() -> void:
	position = FAR_POSITION
	rotation_degrees = FAR_ROTATION
	
func move_close() -> void:
	position = CLOSE_POSITION
	rotation_degrees = CLOSE_ROTATION

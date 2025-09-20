extends MeshInstance3D

@export var ready_material: Material

var y_pos
var height 

func _ready() -> void:
	y_pos = position.y
	height = get_aabb().size.y
	
func recalc_size(progress: float) -> void:
	scale.y = clamp(progress, 0.1, 1.0)
	position.y = y_pos - (height * (1 - progress)) /2
	
func set_ready() -> void:
	mesh.surface_set_material(0, ready_material)

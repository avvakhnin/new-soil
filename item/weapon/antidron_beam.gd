extends RayCast3D

func _process(delta: float) -> void:
	if is_colliding():
		var cast_point = to_local(get_collision_point())
		$MeshInstance3D.mesh.height = cast_point.y
		$MeshInstance3D.position.y = cast_point.y/2
	else:
		$MeshInstance3D.mesh.height = 10
		$MeshInstance3D.position.y = -5

extends RayCast3D

var target: UAV

func _process(delta: float) -> void:
	if ! is_colliding():
		$MeshInstance3D.mesh.height = 100
		$MeshInstance3D.position.y = -50
		if target != null:
			target.freedom()
		return
	
	var cast_point = to_local(get_collision_point())
	$MeshInstance3D.mesh.height = cast_point.y
	$MeshInstance3D.position.y = cast_point.y/2
	
	var par = get_collider().get_parent()
	if par is UAV:
		target = par
		
	if target != null:
		target.catch()
		target.translate((position - target.position).normalized() * (-1)* delta)

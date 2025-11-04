extends Node

func rotate_to_target(object:Node3D, target:Vector3, rotate_angle:float) -> void:
		var forward_direction = -object.global_basis.z;
		var direction_to_target = target - object.global_position;
		
		var angle = forward_direction.angle_to(direction_to_target)
		if angle < rotate_angle: 
			object.transform = object.transform.looking_at(target)
		else:
			var axis = forward_direction.cross(direction_to_target).normalized()
			object.global_basis = Basis(axis, rotate_angle) * object.global_basis 

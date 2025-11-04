extends Weapon

func launch() -> void:
	var character = $"../../../.."
	for spot: ResourceSpot in character.resource_spots:
		var direction_to_area: Vector3 = spot.global_position - character.global_position
		var angle:float = (-character.basis.z).angle_to(direction_to_area)
		if angle > 0.75: continue
		spot.create_items()
		break
	for template: BuildingTemplate in character.templates:
		var direction_to_area: Vector3 = template.global_position - character.global_position
		var angle:float = (-character.basis.z).angle_to(direction_to_area)
		if angle > 0.75: continue
		template.raise_progress(0.3)
		break

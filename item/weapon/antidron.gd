extends Weapon

func launch() -> void:
	$RayCast3D.show()
	await get_tree().create_timer(10).timeout
	$RayCast3D.hide()

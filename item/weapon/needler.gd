extends Weapon

func launch() -> void:
	for i in range(5):
		await get_tree().create_timer(0.1).timeout
		var bullet: Node3D = load("res://item/weapon/bullet.tscn").instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = $LaunchPoint.global_position
		bullet.global_rotation = $LaunchPoint.global_rotation

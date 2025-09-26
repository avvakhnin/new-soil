extends Weapon

func launch() -> void:
	var rocket: Node3D = load("res://item/weapon/rocket.tscn").instantiate()
	get_tree().root.add_child(rocket)
	rocket.global_position = $LaunchPoint.global_position
	rocket.global_rotation = $LaunchPoint.global_rotation

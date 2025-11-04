extends Weapon

func launch() -> void:
	$RayCast3D.show()
	

func dislaunch() -> void:
	$RayCast3D.hide()

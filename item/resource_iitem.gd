extends Node3D
class_name ResourceItem

const SPEED = 10

var target_position: Vector3


func get_storage() -> Storage:
	return $Storage

func _process(delta: float) -> void:
	var direction:Vector3 = target_position - global_position
	var distance = direction.normalized()*SPEED*delta
	if distance < direction: position +=distance 
	else: position = target_position
	

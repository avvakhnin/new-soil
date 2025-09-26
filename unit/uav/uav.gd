class_name UAV extends Node3D

var speed = Vector3.FORWARD*1

func _process(delta: float) -> void:
	transform = transform.translated_local( speed * delta)
	
func exploide() -> void:
	$SM_Ship_Block_01.hide()
	$GPUParticles3D.emitting = true
	await get_tree().create_timer(0.2).timeout
	$GPUParticles3D.emitting = false
	await get_tree().create_timer(0.8).timeout
	queue_free()

class_name UAV extends Node3D

enum {OWN_CONTROL, OUTER_CONTROL}

var control_mode = OWN_CONTROL

@export var speed = Vector3.FORWARD*1

func _process(delta: float) -> void:
	if control_mode == OWN_CONTROL:
		transform = transform.translated_local( speed * delta)
		
func catch() -> void:
	control_mode = OUTER_CONTROL
	speed = Vector3.ZERO
	
	
func freedom() -> void:
	control_mode = OWN_CONTROL
	
func exploide() -> void:
	$SM_Ship_Block_01.hide()
	$GPUParticles3D.emitting = true
	await get_tree().create_timer(0.2).timeout
	$GPUParticles3D.emitting = false
	await get_tree().create_timer(0.8).timeout
	queue_free()

extends Node3D

var speed = Vector3.FORWARD*10
var rotate_speed = 1.9
var target: UAV

func _ready() -> void:
	rotate(Vector3.FORWARD, PI)
	await get_tree().create_timer(100).timeout
	queue_free()

func _process(delta: float) -> void:
	if target != null:
		RotationHelper.rotate_to_target(self, target.global_position, rotate_speed * delta)

		
	transform = transform.translated_local( speed * delta)
	
	if  target != null && (target.position - position).length_squared() < 0.1: 
		target.exploide()
		$GPUParticles3D.emitting = true
		$SM_Wep_Missile_01.hide()
		speed = Vector3.ZERO
		await get_tree().create_timer(0.5).timeout
		$GPUParticles3D.emitting = false
		await get_tree().create_timer(1.5).timeout
		queue_free()

func _on_area_3d_area_entered(area: Area3D) -> void:
	if target == null && area.get_parent() is UAV: target = area.get_parent()

	

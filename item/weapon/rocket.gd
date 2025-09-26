extends Node3D

var speed = Vector3.FORWARD*10

func _ready() -> void:
	await get_tree().create_timer(10).timeout
	queue_free()

func _process(delta: float) -> void:
	transform = transform.translated_local( speed * delta)
	

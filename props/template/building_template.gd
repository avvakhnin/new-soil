class_name BuildingTemplate extends Node3D


@export var building_scene: PackedScene

var progress = 0.0
var is_ready_for_build = false

func _ready() -> void:
	$BlankModel.recalc_size(progress)
	await get_tree().create_timer(3).timeout
	is_ready_for_build = true
	$BlankModel.set_ready()

func raise_progress(additional:float) -> void:
	if !is_ready_for_build: return
	progress +=additional
	$BlankModel.recalc_size(progress)
	
func transmut():
	var building: Node3D = building_scene.instantiate()
	get_parent().add_child(building)
	building.position = position
	building.rotation = rotation
	queue_free()
	
func _process(delta: float) -> void:
	if progress >= 1.0:
		transmut()
		

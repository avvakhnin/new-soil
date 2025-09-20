extends Node3D 
class_name ResourceSpot

@export_range(1, 100, 1)
var count = 10

@export
var item_scene: PackedScene


func create_items() -> void:
	var item_count = clampi( randi_range(1, 3), 1, count)
	for i in item_count:
		create_item()
	
func create_item() -> void:
	
	var item:ResourceItem = item_scene.instantiate()
	get_parent().add_child(item)
	item.position = position
	
	var theta : float = randf() * 2 * PI
	var position_diff = Vector3(cos(theta), 0, sin(theta)) * sqrt(randf())*3
	item.target_position = global_position + position_diff
	
	count -=1
	if count == 0:
		queue_free()

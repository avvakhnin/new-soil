extends Node

var resources: Dictionary[String, int]

func add_resource( resource_item: ResourceItem) -> void:
	var old_value = resources.get(resource_item.type, 0)
	resources[resource_item.type] = old_value + resource_item.count
	resource_item.queue_free()

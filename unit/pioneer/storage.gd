class_name Storage extends Node

@export
var resources: Dictionary[String, int]

func _ready() -> void:
	for resource in resources.keys():
		if resources[resource] == 0: resources.erase(resources)

func add_storage(other: Storage):
	for resource in other.resources:
		add_resource(resource, other.resources[resource])
	other.resources.clear()

func add_resource( resource: String, count: int) -> void:
	var old_value = resources.get(resource, 0)
	resources[resource] = old_value + count

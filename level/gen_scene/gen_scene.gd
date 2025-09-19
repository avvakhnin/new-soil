extends Node3D

@export
var props: Array[PackedScene]

func _ready() -> void:
	for i in  range(0,100):
		var obj = props[randi_range(0, props.size()-1)].instantiate()
		var x = randi_range(-50,50)		
		var z = randi_range(-50,50)
		obj.position  =Vector3(x, 0, z)		
		add_child(obj)
	

extends Node3D

@export
var miscs: Array[PackedScene]

func _ready() -> void:
	for i in  range(0,100):
		var misc = miscs[randi_range(0, miscs.size()-1)].instantiate()
		var x = randi_range(-50,50)		
		var z = randi_range(-50,50)
		misc.position  =Vector3(x, 0, z)		
		#misc.scale = Vector3(0.1, 0.1, 0.1)
		add_child(misc)
	

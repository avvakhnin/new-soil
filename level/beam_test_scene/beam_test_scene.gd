extends Node3D



func _ready() -> void:
	var antidron_beam = load("res://level/beam_test_scene/antidron_beam.tscn").instantiate()
	$Characters/Skeleton/BoneAttachment3D.add_child(antidron_beam)
	var antidron = $Characters/Skeleton/BoneAttachment3D/Antidron
	antidron_beam.transform = antidron.transform
	antidron_beam.visible = antidron.visible
	antidron.queue_free()

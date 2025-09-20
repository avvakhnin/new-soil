extends Node3D

enum {IDLE, WALK, RUN, CHOP}

var mode_animations = {
	IDLE : "idle",
	WALK : "walking",
	RUN : "running_1",
	CHOP : "standing_melee_attack_downward"
}

var mode 

const SPEED = Vector3.FORWARD * 1.4
const RUN_SPEED = Vector3.FORWARD * 3.0
const ROTATE_SPEED = 1.

var is_attack = false

func _process(delta: float):
	if Input.is_action_just_pressed("close_view"):
		$Camera3D.move_close()
	if Input.is_action_just_released("close_view"):
		$Camera3D.move_far()
	
	
	if Input.is_action_just_pressed("create_template"):
		var template: Node3D = load("res://props/template/building_template.tscn").instantiate()
		get_parent().add_child(template)
		template.global_position = global_position + (-basis.z) * 10
		template.global_rotation = global_rotation
		
	var prev_mode = mode
	mode = check_mode()
	$AnimationPlayer.play(mode_animations[mode])
	if mode == CHOP && prev_mode!= CHOP:
		finish_chop()
	if mode == WALK || mode == RUN:
		var speed = SPEED if mode == WALK else RUN_SPEED	
		var move_distance = Input.get_axis("back", "forward") * speed * delta	
		transform  = transform.translated_local(move_distance)
		
	
	if mode == WALK || mode == RUN || mode == IDLE:
		var rotate_angle = Input.get_axis("left", "right") * ROTATE_SPEED * delta
		transform = transform.rotated_local(Vector3.DOWN, rotate_angle)


func check_mode() :
	if mode == CHOP:
		return CHOP
	if mode == IDLE && Input.is_action_just_pressed("attack"):
		return CHOP
	elif (mode == IDLE || mode == WALK || mode == RUN ) \
	&& (Input.is_action_pressed("forward") || Input.is_action_pressed("back")):
		return WALK if ! Input.is_key_pressed(KEY_SHIFT) else RUN	
	else :
		return IDLE
		
func finish_chop():
	await ($AnimationPlayer as AnimationPlayer).animation_finished
	mode = IDLE
	for spot: ResourceSpot in resource_spots:
		var direction_to_area: Vector3 = spot.global_position - global_position
		var angle:float = (-basis.z).angle_to(direction_to_area)
		if angle > 0.75: continue
		spot.create_items()
		break
	for template: BuildingTemplate in templates:
		var direction_to_area: Vector3 = template.global_position - global_position
		var angle:float = (-basis.z).angle_to(direction_to_area)
		if angle > 0.75: continue
		template.raise_progress(0.3)
		break
		
		
var resource_spots: Array[ResourceSpot]
		
var templates: Array[BuildingTemplate]

func _on_area_3d_area_entered(area: Area3D) -> void:	
	var handler = area.get_parent()
	if handler is ResourceSpot: resource_spots.append(handler)
	if handler is ResourceItem: 
		$Backpack.add_storage((handler as ResourceItem).get_storage())
		handler.queue_free()
	if handler is BuildingTemplate: templates.append(handler)
	

func _on_area_3d_area_exited(area: Area3D) -> void:
	var handler = area.get_parent()
	if handler is ResourceSpot: resource_spots.erase(handler)
	if handler is BuildingTemplate: templates.erase(handler)

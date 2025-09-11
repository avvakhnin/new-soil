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
	for area: Area3D in connected_areas:
		var direction_to_area: Vector3 = area.global_position - global_position
		var angle:float = (-basis.z).angle_to(direction_to_area)
		if angle < 0.75: continue
	mode = IDLE
		
		
var connected_areas: Array[Area3D]

func _on_area_3d_area_entered(area: Area3D) -> void:	
	connected_areas.append(area)

func _on_area_3d_area_exited(area: Area3D) -> void:
	connected_areas.erase(area)

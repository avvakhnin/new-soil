extends RayCast3D


enum{Empty, OnCollide, OnTarget}
var state = Empty
var target: UAV

var catch_speed = Vector3.FORWARD*10
var catch_angle_speed = 0.5
var catch_landing_distance = 4

func _process(delta: float) -> void:
	#Translations
	if state == Empty:
		if is_colliding(): 
			state = OnCollide
			if get_collider().get_parent() is UAV:
				state = OnTarget
				catch_target()
		
	if state == OnCollide:
		if !is_colliding(): state = Empty
		elif get_collider().get_parent() is UAV:
			state = OnTarget
			catch_target()
		
	if state == OnTarget:
		if !is_colliding(): 
			state = Empty
			free_target()
		elif !get_collider().get_parent() is UAV:
			state = OnCollide
			free_target()
			
	#Actions
	if state == Empty:
		draw_beam_to_max()
		
	if state == OnCollide:
		draw_beam_to_collide()
		
	if state == OnTarget:
		draw_beam_to_collide()
		$CatchSphere.global_position = target.global_position
		if(get_collision_point() - global_position).length_squared() > catch_landing_distance**2:
			RotationHelper.rotate_to_target(target, get_landing_point(), delta * catch_angle_speed)
			target.translate_object_local(  Vector3.FORWARD * delta)
	
func get_landing_point() -> Vector3:
	return  to_global((basis.z) * catch_landing_distance)
	
	#if ! is_colliding():
		#$MeshInstance3D.mesh.height = 100
		#$MeshInstance3D.position.y = -50
		#if target != null:
			#target.freedom()
			#$CatchSphere.hide()
		#return
	
	#var cast_point = to_local(get_collision_point())
	#$MeshInstance3D.mesh.height = cast_point.y
	#$MeshInstance3D.position.y = cast_point.y/2
	
	#var par = get_collider().get_parent()
	#if par is UAV:
	#	target = par
		
	#if target != null:
		#target.catch()
		#RotationHelper.rotate_to_target(target, position, delta)
		#target.translate_object_local(  Vector3.FORWARD * delta)
		#$CatchSphere.global_position = target.global_position
		#$CatchSphere.show()

func draw_beam_to_max() -> void:
	$MeshInstance3D.mesh.height = 100
	$MeshInstance3D.position.y = -50
	
func draw_beam_to_collide() -> void:
	var cast_point = to_local(get_collision_point())
	$MeshInstance3D.mesh.height = cast_point.y
	$MeshInstance3D.position.y = cast_point.y/2
	
func catch_target() -> void:
	target =  get_collider().get_parent()
	target.catch()
	$CatchSphere.show()
	
func free_target() -> void:
	target.freedom()
	target == null
	$CatchSphere.hide()

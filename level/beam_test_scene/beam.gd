extends RayCast3D

@onready var beam_mesh = $MeshInstance3D
@onready var end_particles = $EndParticles
@onready var beam_particles = $BeamParticles

func _process(delta: float) -> void:
	force_raycast_update()
	if is_colliding():
		var cast_point = to_local(get_collision_point())
		
		beam_mesh.mesh.height = cast_point.y
		beam_mesh.position.y = cast_point.y/2
		
		end_particles.position.y = cast_point.y
		beam_particles.position.y = cast_point.y/2
		
		var particle_amount = snapped(abs(cast_point.y)*50, 1)
		if particle_amount >1:
			beam_particles.amount = particle_amount
		else :
			beam_particles.amount = 1
			
		beam_particles.process_material.set_emission_box_extents(
			Vector3(beam_mesh.mesh.top_radius, abs(cast_point.y)/2, beam_mesh.mesh.top_radius)
		)
		
		
		
		
		

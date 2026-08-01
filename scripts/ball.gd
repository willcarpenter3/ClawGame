extends GrabbableObject

@onready var mesh_container: Node3D = $MeshContainer

func initialize(pos: Vector3, newScale: Vector3):
	position = pos
	
	#var material = StandardMaterial3D.new()
	#material.albedo_color = Color(randf(), randf(), randf(), 1)
	#material.roughness = 0.25
	#material.metallic = 0.75
	#mesh.material_override = material
	
	var mesh = mesh_container.get_children().pick_random()
	mesh.visible = true
	
	
	linear_velocity = Vector3.ZERO
	
	scale = newScale

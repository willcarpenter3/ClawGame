extends GrabbableObject

@onready var mesh := $MeshInstance3D

func initialize(pos: Vector3, newScale: Vector3):
	position = pos
	
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(randf(), randf(), randf(), 1)
	material.roughness = 0.25
	material.metallic = 0.75
	mesh.material_override = material
	
	scale = newScale

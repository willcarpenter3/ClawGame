extends Node3D

@export var thingToSpawn : PackedScene
@export var numToSpawn := 3
@export var spawnRadius : float
@export var scaleRandomness := 0.2

@onready var spawn_loc = $SpawnPath/SpawnPathLoc


func _on_timer_timeout() -> void:
	print("Timer going off!")
	
	
	var spawnedThing = thingToSpawn.instantiate()
	var spawnX = randf_range(-spawnRadius, spawnRadius) + position.x
	var spawnZ = randf_range(-spawnRadius, spawnRadius) + position.z
	
	add_child(spawnedThing)
	spawnedThing.initialize(Vector3(spawnX, position.y, spawnZ), Vector3.ONE * (1 + randf_range(-scaleRandomness, scaleRandomness)))
	


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.

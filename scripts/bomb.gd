extends Node3D

@onready var timer: Timer = $Timer
@onready var area_3d: Area3D = $RigidBody3D/Area3D

@export var explosion_force := 100.0

func explode():
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body is not RigidBody3D:
			continue
		print("Applying explosion force")
		var dist = body.position.distance_to(position)
		var dir = body.position - position
		
		var impulse = dir * (explosion_force / dist)
		
		body.apply_central_impulse(impulse)


func _on_timer_timeout() -> void:
	explode()
	print("BOOM!")
	queue_free()

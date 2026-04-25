extends Area3D

var points := 0

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if body is GrabbableObject:
		points += 1
		print("Points: ", points)

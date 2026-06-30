extends Area3D

func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if body is GrabbableObject:
		GameManager.score = GameManager.score + 1
		$"../GameUI".update_score_text(GameManager.score)
		%ObjectPool.add_to_pool(body)
		

extends Node

class_name ObjectPool

@export var scene : PackedScene

var object_pool : Array = []

func add_to_pool(object: Node) -> void:
	object_pool.append(object)
	object.set_process(false)
	object.set_physics_process(false)
	object.hide()
	return
	
func draw_from_pool() -> Node:
	var object: Node
	if object_pool.is_empty():
		return scene.instantiate()
	else:
		object = object_pool.pop_back()
	object.set_process(true)
	object.set_physics_process(true)
	object.show()
	return object

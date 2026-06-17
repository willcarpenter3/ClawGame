extends Node3D
class_name AutoClawParent

func initialize(pos: Vector3, auto_pos: Vector3):
	position = pos
	$ClawMover.auto_position = auto_pos

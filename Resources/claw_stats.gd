class_name ClawStats
extends Resource

@export var speed : float
@export var drop_speed : float
@export var raise_speed_mult : float
@export var return_speed_mult : float
@export var return_position : Vector3

func _init(
		p_speed = 10.0, 
		p_drop_speed = 1.0, 
		p_raise_speed_mult = 1.0,
		p_return_speed_mult = 1.0,
		p_return_pos = Vector3(0,0,0),
	):
	speed = p_speed
	drop_speed = p_drop_speed
	raise_speed_mult = p_raise_speed_mult
	return_speed_mult = p_return_speed_mult
	return_position = p_return_pos
	

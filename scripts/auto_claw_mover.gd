class_name AutoClawMover
extends Claw

@export var auto_position := Vector3(0, 0, 0)

func _init() -> void:
	return

func initialize(pos: Vector3) -> void:
	position = pos
	
func _input(_event: InputEvent) -> void:
	#Don't want auto-claw to be affected by inputs
	return
	
func calc_manual_movement(direction: Vector3):
	if drop_timer.time_left > 0:
		target_velocity = Vector3.ZERO
		return
	
	var distance = global_position.distance_to(auto_position)
	
	if distance <= 0.5: 
		target_velocity = Vector3.ZERO
		initiate_drop()
		return
	
	direction = auto_position - global_position
	direction = direction.normalized()
	
	target_velocity.x = direction.x * stats.speed * stats.return_speed_mult
	target_velocity.z = direction.z * stats.speed * stats.return_speed_mult
	

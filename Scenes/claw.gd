extends CharacterBody3D

enum MovementMode {Manual, Grabbing, Raising, Returning}

@export var speed := 10.0
@export var camera: Camera3D

@export var grab_speed := 10
@export var grab_distance := 40.0

@export var raise_speed := 10

@export var return_position := Vector3(-30, 50, -30)
@export var return_speed := 10

#Private Movement Variables
var movement_mode: MovementMode = MovementMode.Manual
var target_velocity: Vector3 = Vector3.ZERO
var target_grab_location: Vector3
var target_raise_location: Vector3


func _input(event: InputEvent) -> void:
	if event.is_action("ActivateClaw") and movement_mode == MovementMode.Manual:
		initiate_grab()
		
func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
			
	match movement_mode:
		MovementMode.Manual:
			calc_manual_movement(direction)
		MovementMode.Grabbing:
			calc_grab_movement()
		MovementMode.Raising:
			calc_raise_movement()
		MovementMode.Returning:
			calc_return_movement()
		_:
			calc_manual_movement(direction)

	velocity = target_velocity
	move_and_slide()
	
func calc_manual_movement(direction: Vector3):
	if Input.is_action_pressed("MoveRight"):
		direction.x += 1
	if Input.is_action_pressed("MoveLeft"):
		direction.x -= 1
	if Input.is_action_pressed("MoveDown"):
		direction.z += 1
	if Input.is_action_pressed("MoveUp"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()

	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	
func calc_grab_movement():
	if position.y <= target_grab_location.y:
		#TODO implement grabbing action here
		initiate_raise()
	else: 
		target_velocity.y = -grab_speed
	
func calc_raise_movement():
	if position.y >= target_raise_location.y:
		initiate_return()
	else:
		target_velocity.y = raise_speed
		
func calc_return_movement():
	var distance = position.distance_to(return_position)
	
	print(distance)
	if distance <= 0.5: 
		#TODO implement dropping logic here
		initiate_manual_control()
	
	var direction = return_position - position
	direction = direction.normalized()
	
	target_velocity.x = direction.x * return_speed
	target_velocity.z = direction.z * return_speed
	
func initiate_manual_control():
	print("You're back in control!")
	target_velocity = Vector3.ZERO
	movement_mode = MovementMode.Manual

func initiate_grab():
	print("Grabbing!")
	target_velocity = Vector3.ZERO
	movement_mode = MovementMode.Grabbing
	target_grab_location = position - Vector3(0, grab_distance, 0)
	target_raise_location = position

func initiate_raise():
	target_velocity = Vector3.ZERO
	movement_mode = MovementMode.Raising
	
func initiate_return():
	target_velocity = Vector3.ZERO
	movement_mode = MovementMode.Returning
	print("Returning!")

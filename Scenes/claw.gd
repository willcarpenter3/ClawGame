extends CharacterBody3D

enum MovementMode {Manual, Grabbing, Raising, Returning}

@export var speed := 10.0
@export var camera: Camera3D

@export var drop_speed := 10
@onready var drop_timer: Timer = $DropTimer

@export var grab_arm : RigidBody3D

@export var raise_speed := 10

@export var return_position := Vector3(-30, 50, -30)
@export var return_speed := 10
@onready var release_timer: Timer = $ReleaseTimer

@export var hinges : Array[HingeJoint3D]
@onready var grab_timer : Timer = $GrabTimer

#Private Movement Variables
var movement_mode: MovementMode = MovementMode.Manual
var target_velocity: Vector3 = Vector3.ZERO
var target_grab_location: Vector3
var target_raise_location: Vector3

var current_grab_joint : Generic6DOFJoint3D

func _input(event: InputEvent) -> void:
	if event.is_action("ActivateClaw") and movement_mode == MovementMode.Manual:
		initiate_drop()
		
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
	if grab_timer.time_left > 0:
		target_velocity = Vector3.ZERO
		return
		
	target_velocity.y = -drop_speed
	
func calc_raise_movement():
	if position.y >= target_raise_location.y:
		position.y = target_raise_location.y
		initiate_return()
	else:
		target_velocity.y = raise_speed
		
func calc_return_movement():
	if release_timer.time_left > 0:
		target_velocity = Vector3.ZERO
		return
	
	var distance = global_position.distance_to(return_position)
	
	print(distance)
	if distance <= 0.5: 
		release_timer.start()
	
	var direction = return_position - global_position
	direction = direction.normalized()
	
	target_velocity.x = direction.x * return_speed
	target_velocity.z = direction.z * return_speed
	
func initiate_manual_control():
	print("You're back in control!")
	target_velocity = Vector3.ZERO
	movement_mode = MovementMode.Manual

func initiate_drop():
	print("Dropping!")
	target_velocity = Vector3.ZERO
	movement_mode = MovementMode.Grabbing
	drop_timer.start()
	target_raise_location = position
	

func initiate_raise():
	target_velocity = Vector3.ZERO
	movement_mode = MovementMode.Raising
	
func initiate_return():
	target_velocity = Vector3.ZERO
	movement_mode = MovementMode.Returning
	print("Returning!")
	
func initiate_grab():
	print("Grabbing!")
	for hinge in hinges:
		hinge.set("motor/target_velocity", 50)
	grab_timer.start()
	

func _on_drop_timer_timeout() -> void:
	initiate_grab()

func _on_grab_detection_body_entered(body: Node3D) -> void:
	if body is GrabbableObject and current_grab_joint == null and movement_mode == MovementMode.Grabbing:
		current_grab_joint = body.try_grab(grab_arm)

func _on_release_timer_timeout() -> void:
	for hinge in hinges:
		hinge.set("motor/target_velocity", -50)
		
	if current_grab_joint:
		current_grab_joint.get_parent_node_3d().release()
		current_grab_joint = null
	initiate_manual_control()


func _on_grab_timer_timeout() -> void:
	initiate_raise()

func _on_grab_detection_body_exited(body: Node3D) -> void:
	if body is GrabbableObject:
		body.release()

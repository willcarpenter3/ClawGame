extends CharacterBody3D

@export var speed := 10.0
@export var camera: Camera3D

const RAY_LENGTH := 20;

var targetPos: Vector3
var target_velocity: Vector3 = Vector3.ZERO

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#Convert mouse position to real world coordinates
		#var rayOrigin = camera.project_ray_origin(event.position)
		#targetPos = rayOrigin + camera.project_ray_normal(event.position) * RAY_LENGTH
	
		
func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	#Lerp to our mouse cursor
	#var direction = targetPos - position
	#if direction.length() > 0.2:
			#velocity = direction * speed * delta
			#move_and_slide()
			
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

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	velocity = target_velocity
	move_and_slide()

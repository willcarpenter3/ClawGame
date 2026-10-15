extends Node3D


const GYRO_SENSITIVITY = 1.0
const MOUSE_SENSITIVITY = 0.01

func _ready():
	# In this example we only use the first connected joypad (id 0).
	if 0 not in Input.get_connected_joypads():
		return

	if not Input.has_joy_motion_sensors(0):
		return

	# We must enable the motion sensors before using them.
	Input.set_joy_motion_sensors_enabled(0, true)

	# (Tell the users here that they need to put their joypads on a flat surface and wait for confirmation.)

	# Start the calibration process.
	calibrate_motion()

func _process(delta):
	# Only move the object if the joypad motion sensors are calibrated.
	if Input.is_joy_motion_sensors_calibrated(0):
		gyro_move_object(delta)

func _input(event: InputEvent):
	if Input.is_joy_motion_sensors_calibrated(0):
		return
	elif event is InputEventMouseMotion:
		mouse_move_object(event)

func calibrate_motion():
	Input.start_joy_motion_sensors_calibration(0)

	# Wait for some time.
	await get_tree().create_timer(1.0).timeout

	Input.stop_joy_motion_sensors_calibration(0)
	# The joypad is now calibrated.

func gyro_move_object(delta):
	var gyro := Input.get_joy_gyroscope(0)
	var newY = -gyro.y * GYRO_SENSITIVITY * delta # Use rotation around the Y axis (yaw) here.
	var newX = gyro.x * GYRO_SENSITIVITY * delta  # Use rotation around the X axis (pitch) here.
	
	rotation.y = clamp(rotation.y - newY, -1, 1)
	rotation.x = clamp(rotation.x - newX, -1, 1)
	
func mouse_move_object(event: InputEventMouseMotion):
	var newX = event.screen_relative.x * MOUSE_SENSITIVITY
	var newY = event.screen_relative.y * MOUSE_SENSITIVITY
	
	
	rotation.x = clamp(rotation.x + newY, -1, 1)
	rotation.y = clamp(rotation.y + newX, -1, 1)

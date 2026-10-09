extends Camera3D

@export var target_pos: Vector3
@export var path_follow_3d: PathFollow3D

func _physics_process(_delta):
	look_at(target_pos)
	
	if Input.is_action_pressed("RotateCameraRight"):
		var new_progress = clamp(path_follow_3d.progress_ratio + .01, 0, 1)
		path_follow_3d.progress_ratio = new_progress
	elif Input.is_action_pressed("RotateCameraLeft"):
		var new_progress = clamp(path_follow_3d.progress_ratio - .01, 0, 1)
		path_follow_3d.progress_ratio = new_progress
	#else:
		#if path_follow_3d.progress_ratio > 0.5:
			#path_follow_3d.progress_ratio -= .01
		#else:
			#path_follow_3d.progress_ratio += .01

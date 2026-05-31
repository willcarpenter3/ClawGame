extends RigidBody3D

class_name GrabbableObject

@onready var grab_joint: Generic6DOFJoint3D = $GrabJoint

func try_grab(body: RigidBody3D) -> Generic6DOFJoint3D:
	print("Trying Grab!")
	grab_joint.node_a = body.get_path()
	grab_joint.node_b = $".".get_path()
	return grab_joint
	
func release():
	grab_joint.node_a = ""
	grab_joint.node_b = ""

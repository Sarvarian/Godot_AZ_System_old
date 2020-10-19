extends CharacterComponent


class_name Rotate2D


export(int, 0, 1000) var force : int = 500 # Rigid body
export(int, 0, 360) var degrees : int = 90 # Node2D


func rotate_right() -> void:
	rotate_parent(1)
func rotate_left() -> void:
	rotate_parent(-1)


func rotate_parent(dir : int) -> void:
	if get_parent() is RigidBody2D:
		(get_parent() as RigidBody2D).apply_torque_impulse(force * dir)
	elif get_parent() is Node2D:
		get_parent().rotate(deg2rad(degrees * dir))







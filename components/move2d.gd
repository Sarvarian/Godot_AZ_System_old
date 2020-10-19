extends Component


class_name Move2D


enum State {INDEPENDENT, LOOK_DEPENDENT}


export(NodePath) var camera2d_path
export(int, 100, 10000) var speed : int = 4000
export(State) var state : int = State.INDEPENDENT
export var linear_dump : int = 6

var speed_filter : float = 1
var frame_dir : Vector2 = Vector2.ZERO
var persist_dir : Vector2 = Vector2.ZERO
var cam2d : Camera2D = null


func _ready() -> void:
	find_cam2d()
	if get_parent() is RigidBody2D:
		get_parent().linear_damp = linear_dump
	pass


func find_cam2d() -> void:
	if camera2d_path:
		cam2d = get_node(camera2d_path) as Camera2D
	if not cam2d:
		for n in get_parent().get_children():
			if n is Camera2D:
				cam2d = n


func _physics_process(delta : float) -> void:
	var dir : Vector2 = direction()
	if dir.length_squared() > 1: dir = dir.normalized()
	var vel : Vector2 = dir * speed * speed_filter * delta
	if get_parent() is RigidBody2D:
		get_parent().apply_central_impulse(vel)
	elif get_parent() is KinematicBody2D:
		get_parent().move_and_slide(vel*9)
	elif get_parent() is Node2D:
		get_parent().global_position += vel*.15
	frame_dir = Vector2.ZERO


func direction() -> Vector2:
	var dir : Vector2 = Vector2.ZERO
	var md : Vector2 = move_dir()
	if get_parent() is Node2D and state == State.LOOK_DEPENDENT:
		dir.x = -md.y
		dir = dir.rotated(get_parent().global_rotation)
	elif cam2d and cam2d.current and cam2d.rotating:
		dir = md.rotated(get_parent().global_rotation + deg2rad(90))
	else:
		dir = md
	return dir


func move_dir() -> Vector2:
	if persist_dir != Vector2.ZERO:
		return persist_dir
	else:
		return frame_dir

extends CharacterComponent


class_name Look2D


enum State {FORWARD, DIRECTION, MOUSE, TARGET}


export(NodePath) var camera2d_path
export(NodePath) var move2d_path
export(int, 10000, 1000000) var speed : int = 100000
export(State) var state : int = State.FORWARD
export var angular_damp : float = 6

var speed_filter : float = 1
var frame_dir : Vector2 = Vector2.ZERO
var persist_dir : Vector2 = Vector2.ZERO
var cam2d : Camera2D = null
var move2d : Move2D = null


func _ready() -> void:
	find_cam2d()
	find_move2d()
	get_parent().angular_damp = angular_damp
	pass


func find_cam2d() -> void:
	if camera2d_path:
		cam2d = get_node(camera2d_path) as Camera2D
	if not cam2d:
		for n in get_parent().get_children():
			if n is Camera2D:
				cam2d = n


func find_move2d() -> void:
	if move2d_path:
		move2d = get_node(move2d_path) as Move2D
	if not move2d:
		for n in get_parent().get_children():
			if n is Move2D:
				move2d = n


func _physics_process(delta : float) -> void:
	get_parent().apply_torque_impulse(rotang() * speed * speed_filter * delta)
	frame_dir = Vector2.ZERO


func look_dir() -> Vector2:
	if persist_dir != Vector2.ZERO:
		return persist_dir
	else:
		return frame_dir


###################
#### Analyzser ####
###             ###
const ID : int = Move2D.State.INDEPENDENT
const LD : int = Move2D.State.LOOK_DEPENDENT

const F : int = State.FORWARD
const D : int = State.DIRECTION
const M : int = State.MOUSE
const T : int = State.TARGET

func rotang() -> float:
	var cr : bool = cam2d.rotating
	var ms : int = move2d.state
	var ls : int = state
	
	
	match cr:
		false: match ms:
			ID: match ls:
				F: return IDF()
				D: return IDD()
				M: return IDM()
				T: return IDT()
			
			LD: match ls:
				F: return LDF()
				D: return LDD()
				M: return LDM()
				T: return LDT()
		
		true: match ms:
			ID: match ls:
				F: return CRIDF()
				D: return CRIDD()
				M: return CRIDM()
				T: return CRIDT()
			
			LD: match ls:
				F: return CRLDF()
				D: return CRLDD()
				M: return CRLDM()
				T: return CRLDT()
	
	return .0


func IDF() -> float:
	return get_parent().get_angle_to(get_parent().global_position + move2d.move_dir())


func IDD() -> float:
	if look_dir() == Vector2.ZERO: return .0
	print(frame_dir)
	return get_parent().get_angle_to(get_parent().global_position + look_dir())


func IDM() -> float:
	if look_dir() != Vector2.ZERO:
		state = State.DIRECTION
	return get_parent().get_local_mouse_position().angle()


func IDT() -> float: # TODO: needs targeting
	return .0
#	if not c.look_target:
#		c.look_state = System.LookState.DIRECTION
#		return .0
#	return c.get_angle_to(c.look_target.global_position)


# TODO Test, Analyze and Fix the Potential BUGs
func LDF() -> float:
	var strength : float = clamp((move2d.frame_dir.x + frame_dir.x), -1, 1)
	var rot : float = deg2rad(200 * strength)
	if frame_dir.y > .5: rot *= 3
	frame_dir = Vector2.RIGHT.rotated(get_parent().global_rotation + rot)
	persist_dir = Vector2.ZERO
	return IDD()


func LDD() -> float:
	return IDD()

func LDM() -> float:
	return IDM()

func LDT() -> float:
	return IDT()

func CRIDF() -> float:
	return CRLDF()

func CRIDD() -> float:
	return CRLDD()

func CRIDM() -> float:
	return CRLDM()

func CRIDT() -> float:
	return CRLDT()

func CRLDF() -> float:
	return LDF()

func CRLDD() -> float:
	# TODO This!!! Design This!!!
	return IDD()

func CRLDM() -> float:
	return IDM()

func CRLDT() -> float:
	return IDT()

extends ComponentInput


class_name Look2DInput


export var look_up : String = "look_up"
export var look_left : String = "look_left"
export var look_down : String = "look_down"
export var look_right : String = "look_right"


func print_parent_isnt_look2d() -> void:
	print_an_error("I am a Look2DInput but my parent is not a Look2D")


func _ready() -> void:
	if not get_parent() is Look2D:
		print_parent_isnt_look2d()
	
	set_action(look_up)
	set_action(look_left)
	set_action(look_down)
	set_action(look_right)


func _physics_process(_delta: float) -> void:
	var look2d : Look2D = get_parent() as Look2D
	if not look2d:
		print_parent_isnt_look2d()
		return
	
	if Input.is_action_pressed(action(look_up)):
		look2d.frame_dir += Vector2.UP * Input.get_action_strength(action(look_up))
	
	if Input.is_action_pressed(action(look_left)):
		look2d.frame_dir += Vector2.LEFT * Input.get_action_strength(action(look_left))
	
	if Input.is_action_pressed(action(look_down)):
		look2d.frame_dir += Vector2.DOWN * Input.get_action_strength(action(look_down))
	
	if Input.is_action_pressed(action(look_right)):
		look2d.frame_dir += Vector2.RIGHT * Input.get_action_strength(action(look_right))
	
	





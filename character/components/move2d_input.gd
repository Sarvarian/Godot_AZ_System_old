extends ComponentInput


class_name Move2DInput


export var move_up : String = "move_up"
export var move_left : String = "move_left"
export var move_down : String = "move_down"
export var move_right : String = "move_right"


func print_parent_isnt_move2d() -> void:
	print_an_error("I am a Move2DInput but my parent is not a Move2D")


func _ready() -> void:
	if not get_parent() is Move2D:
		print_parent_isnt_move2d()
	
	set_action(move_up)
	set_action(move_left)
	set_action(move_down)
	set_action(move_right)


func _physics_process(_delta: float) -> void:
	var move2d : Move2D = get_parent() as Move2D
	if not move2d:
		print_parent_isnt_move2d()
		return
	
	if Input.is_action_pressed(action(move_up)):
		move2d.frame_dir += Vector2.UP * Input.get_action_strength(action(move_up))
	
	if Input.is_action_pressed(action(move_left)):
		move2d.frame_dir += Vector2.LEFT * Input.get_action_strength(action(move_left))
	
	if Input.is_action_pressed(action(move_down)):
		move2d.frame_dir += Vector2.DOWN * Input.get_action_strength(action(move_down))
	
	if Input.is_action_pressed(action(move_right)):
		move2d.frame_dir += Vector2.RIGHT * Input.get_action_strength(action(move_right))
	
	





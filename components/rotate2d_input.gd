extends ComponentInput


class_name Rotate2DInput


export var rotate_left : String = "rotate_left"
export var rotate_right : String = "rotate_right"


func print_parent_isnt_rotate2d() -> void:
	print_an_error("I am a Rotate2DInput but my parent is not a Rotate2D")


func _ready() -> void:
	if not get_parent() is Rotate2D:
		print_parent_isnt_rotate2d()
	
	set_action(rotate_left)
	set_action(rotate_right)


func _input(event : InputEvent) -> void:
	var rotate2d : Rotate2D = get_parent() as Rotate2D
	if not rotate2d:
		print_parent_isnt_rotate2d()
		return
	
	if event.is_action(action(rotate_left)):
		rotate2d.rotate_left()
	
	if event.is_action(action(rotate_right)):
		rotate2d.rotate_right()


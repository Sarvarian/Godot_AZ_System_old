extends ComponentInput


class_name PlayerCamera2DInput


export var camera_zoom_in : String = "camera_zoom_in"
export var camera_zoom_out : String = "camera_zoom_out"


func print_parent_isnt_cam2d() -> void:
	print_an_error("I am a PlayerCamera2DInput but my parent is not a PlayerCamera2D")


func _ready() -> void:
	if not get_parent() is PlayerCamera2D:
		print_parent_isnt_cam2d()
	
	set_action(camera_zoom_in)
	set_action(camera_zoom_out)


func _input(event : InputEvent) -> void:
	var cam2d : PlayerCamera2D = get_parent() as PlayerCamera2D
	if not cam2d:
		print_parent_isnt_cam2d()
		return
	if not cam2d.current: return
	
	if event.is_action_released(action(camera_zoom_in)):
		cam2d.zoom_in()
	if event.is_action_released(action(camera_zoom_out)):
		cam2d.zoom_out()


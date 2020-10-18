extends Camera2D


class_name PlayerCamera2D


export var CHANGE_STEP : Vector2 = Vector2(.1, .1)
export var MIN_ZOOM : Vector2 = Vector2(1, 1)
export var MAX_ZOOM : Vector2 = Vector2(2, 2)

var tween : Tween = Tween.new()

onready var target_zoom : Vector2 = zoom

func _ready() -> void:
	add_child(tween)


func zoom_in() -> void:
	target_zoom -= CHANGE_STEP
	zoom_act()


func zoom_out() -> void:
	target_zoom += CHANGE_STEP
	zoom_act()


func zoom_act() -> void:
	target_zoom.x = clamp(target_zoom.x, MIN_ZOOM.x, MAX_ZOOM.x)
	target_zoom.y = clamp(target_zoom.y, MIN_ZOOM.y, MAX_ZOOM.y)
# warning-ignore:return_value_discarded
	tween.interpolate_property(self, NodePath("zoom"),
		null, target_zoom, .2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
# warning-ignore:return_value_discarded
	tween.start()







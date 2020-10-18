extends Setting


class_name EventSetting


static func action(player_index : int, action_name : String) -> String:
	return "player" + str(player_index) + "_" + action_name


static func set_action(player_index : int, action_name : String) -> void:
	if not InputMap.has_action(action(player_index, action_name)):
		InputMap.add_action(action(player_index, action_name))


static func add_mouse_button_event(player_index : int, action_name : String, button_index : int) -> void:
	var event : InputEventMouseButton = InputEventMouseButton.new()
	event.button_index = button_index
	set_action(player_index, action_name)
	InputMap.action_add_event(action(player_index, action_name), event)





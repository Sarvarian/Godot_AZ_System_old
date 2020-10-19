extends Setting


class_name EventSetting


static func action(action_name : String, player_index : int = 0) -> String:
	return "player" + str(player_index) + "_" + action_name


static func set_action(action_name : String, player_index : int = 0) -> void:
	if not InputMap.has_action(action(action_name, player_index)):
		InputMap.add_action(action(action_name, player_index))


static func add_mouse_button_event(
	action_name : String,
	button_index : int,
	player_index : int = 0,
	device : int = 0
	) -> void:
	
	set_action(action_name, player_index)
	var event : InputEventMouseButton = InputEventMouseButton.new()
	event.button_index = button_index
	event.device = device
	InputMap.action_add_event(action(action_name, player_index), event)


static func add_mouse_button_event_from_to(
	action_name : String,
	button_index : int,
	from_player : int = 0,
	to_player : int = 99,
	from_device : int = 0
	) -> void:
	
	while from_player < to_player:
		add_mouse_button_event(action_name, button_index, from_player, from_device)
		from_device += 1
		from_player += 1


static func add_key_event(
	action_name : String,
	scancode : int,
	player_index : int = 0,
	device : int = 0
	) -> void:
	
	set_action(action_name, player_index)
	var event : InputEventKey = InputEventKey.new()
	event.scancode = scancode
	event.device = device
	InputMap.action_add_event(action(action_name, player_index), event)


static func add_key_event_from_to(
	action_name : String,
	scancode : int,
	from_player : int = 0,
	to_player : int = 99,
	from_device : int = 0
	) -> void:
	
	while from_player < to_player:
		add_key_event(action_name, scancode, from_player, from_device)
		from_device += 1
		from_player += 1

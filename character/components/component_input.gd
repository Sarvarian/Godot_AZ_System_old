extends CharacterComponent


class_name ComponentInput


func print_an_error(message) -> void:
	PrintErr.component_input(
		name,
		get_instance_id(),
		get_parent().name,
		get_parent().get_instance_id(),
		get_parent().get_parent().name,
		get_parent().get_parent().get_instance_id(),
		message
		)


func print_parent_parent_isnt_character_error() -> void:
	print_an_error("I am a ComponentInput but parent of my parent is not a Character")


func _ready():
	if not get_parent().get_parent().has_method("get_player_index"):
			print_parent_parent_isnt_character_error()


func player_index() -> int:
	if get_parent().get_parent().has_method("get_player_index"):
		if not get_parent().get_parent().get_player_index() < 0:
			return get_parent().get_parent().get_player_index()
	return get_parent().get_parent().get_index()


func action(name : String) -> String:
	return EventSetting.action(name, player_index())


func set_action(name : String) -> void:
	EventSetting.set_action(name, player_index())





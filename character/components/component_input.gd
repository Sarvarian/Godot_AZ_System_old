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
	if not get_parent().get_parent() is Character:
		print_parent_parent_isnt_character_error()
	


func player_index() -> int:
	var pp : Character = get_parent().get_parent() as Character
	if pp:
		if pp.player_index < 0:
			return pp.get_index()
		else:
			return pp.player_index
	else:
		print_parent_parent_isnt_character_error()
		return get_parent().get_parent().get_index()


func action(name : String) -> String:
	return EventSetting.action(name, player_index())


func set_action(name : String) -> void:
	EventSetting.set_action(name, player_index())





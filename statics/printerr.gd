extends Object


class_name PrintErr


static func add_anim_to_animplr(
	animation_player : AnimationPlayer,
	anim_name : String,
	error_code : int,
	your_name,
	your_id,
	animation : Animation
	) -> void:
	
	# Construct Message
	var msg : String = "\n"
	msg += "AnimationPlayer Name: \"%s\" ID: \"%s\" with Parent Name: \"%s\" ID: \"%s\" Error: \"%s\"\n" % [
		animation_player.name,
		animation_player.get_instance_id(),
		animation_player.get_parent().name,
		animation_player.get_instance_id(),
		error_code,
		]
	msg += "When We try to add animation Name: \"%s\" from Node Name: \"%s\" ID: \"%s\"\n" % [
		anim_name,
		your_name,
		your_id,
		]
	msg += "Animation Resource Name: \"%s\" Path: \"%s\" ID \"%s\"\n" % [
		animation.resource_name,
		animation.resource_path,
		animation.get_instance_id(),
		]

	# Print
	printerr(msg)


static func component_input(
		name : String,
		id : int,
		parent_name : String,
		parent_id : int,
		parent_of_parent_name : String,
		parent_of_parent_id : int,
		message : String
		) -> void:
	
	# Construct Message
	var msg : String = "\n"
	msg += "my Name: \"%s\" ID: \"%s\"\n" % [
		name,
		id,
		]
	msg += "my parent Name: \"%s\" ID: \"%s\"\n" % [
		parent_name,
		parent_id,
	]
	msg += "my parent of parent Name: \"%s\" ID: \"%s\"\n" % [
		parent_of_parent_name,
		parent_of_parent_id,
	]
	msg += message
	
	# Print
	printerr(msg)











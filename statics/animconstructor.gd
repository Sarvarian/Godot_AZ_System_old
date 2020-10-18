extends Object


class_name AnimationConstructor


static func death_fade(character : NodePath, death : NodePath, method : Dictionary) -> Animation:
	var animation = Animation.new()
	
	var modulate_track = animation.add_track(Animation.TYPE_VALUE)
	animation.track_set_path(modulate_track, String(character) + ":modulate")
	animation.track_insert_key(modulate_track, 0.0, Color(1, 1, 1))
	animation.track_insert_key(modulate_track, 1.0, Color(.4, .4, .4))
	
	var function_track = animation.add_track(Animation.TYPE_METHOD)
	animation.track_set_path(function_track, death)
	animation.track_insert_key(function_track, 1.0, method)
	
	return animation

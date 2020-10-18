extends CharacterComponent


class_name Death


export var animation_player_path : NodePath
const anim_name := "Death"
var anim : Animation = null
var animplr : AnimationPlayer = null


func _ready() -> void:
	if find_animplr():
		make_anim()
		add_anim_to_animplr()


func find_animplr() -> bool:
	if animation_player_path:
		animplr = get_node(animation_player_path) as AnimationPlayer
	if animplr:
		return true
	else:
		for n in get_parent().get_children():
			if n is AnimationPlayer:
				animplr = n
				return true
	return false


func make_anim() -> void:
	if anim: anim.free()
	anim = AnimationConstructor.death_fade(
		get_parent().get_path(),
		get_path(),
		{method = "call_after_death", args = []}
		)


func add_anim_to_animplr() -> void:
	if animplr && anim:
		var err : int = animplr.add_animation(anim_name, anim)
		if err != OK:
			PrintErr.add_anim_to_animplr(
				animplr,
				anim_name,
				err,
				name,
				get_instance_id(),
				anim
				)


func die() -> void:
	if animplr:
		animplr.play(anim_name)


func call_after_death() -> void:
	print("I'm Dead now!")
#	c.set_mode(RigidBody2D.MODE_STATIC)
#	c.collision.set_disabled(true)
#	if c.dead_list:
#		var sprite_trans : Transform2D = c.sprite.global_transform
#		var cam_trans : Transform2D = c.camera.get_global_transform()
#		c.remove_child(c.sprite)
#		c.remove_child(c.camera)
#		c.dead_list.add_child(c.sprite)
#		c.dead_list.add_child(c.camera)
#		c.sprite.set_global_transform(sprite_trans)
#		c.sprite.set_modulate(c.get_modulate())
#		c.camera.set_global_transform(cam_trans)
#		c.get_parent().remove_child(c)
#		c.queue_free()
	pass




extends Node2D


class_name Spawner


export(Array, PackedScene) var scenes : Array
export(float, 0, 60) var time : float = 1
export(int, 1, 99) var child_limit : int = 5
export(int, 1, 99) var repeat_limit : int = 2
export(int, 1, 99) var future_limit : int = 1

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var timer : float = time
var index_history : PoolIntArray = []
var next_indexes : PoolIntArray = []


func _ready() -> void:
	if future_limit <= 0: future_limit = 1
	for _i in range(repeat_limit + future_limit):
		index_history.append(-1)
	for _i in range(future_limit):
		set_next_index()
	rng.set_seed(int(OS.get_unique_id()))


func _physics_process(delta : float):
	if timer <= 0 and get_child_count() < child_limit:
		spawn()
	if timer < 0: timer = time
	timer -= delta


func spawn() -> void:
	erase_extra_history()
	var index : int = -1
	index = next_indexes[0]
	next_indexes.remove(0)
	set_next_index()
#	print(index_history, " / ", index, " / ", next_indexes) # DEBUG
	add_child(scenes[index].instance())


func set_next_index() -> void:
	var index : int = -1
	while true:
		index = rng.randi_range(0, scenes.size()-1)
		if not is_index_get_repetitive(index):
			break
	index_history.push_back(index)
	next_indexes.push_back(index)


func erase_extra_history() -> void:
	for i in index_history.size():
		if index_history.size() > repeat_limit + future_limit:
			index_history.remove(0)
		else:
			return


func is_index_get_repetitive(index : int) -> bool:
	for i in range(repeat_limit):
		if index_history[index_history.size() - (i+1)] != index:
			return false
	return true


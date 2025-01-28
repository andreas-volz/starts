class_name Utils
extends RefCounted
# Godot 4

## check in most compatible way if an object instance is valid
static func is_valid(object) -> bool:
	if object and is_instance_valid(object):
		return true
	return false

## check if a point is between to points (which are effective a way to check a point inside a rect)
#static func is_inside(value: Vector2, point1: Vector2, point2: Vector2, border1_including:bool = true, border2_including:bool = true):
#	var between1 = is_between(value.x, point1.x, point2.x, border1_including, border2_including)
#	var between2 = is_between(value.y, point1.y, point2.y, border1_including, border2_including)
#	
#	return between1 and between2
	
## check if a value is between border1 and border2
static func is_between(value, border1, border2, border1_including:bool = true, border2_including:bool = true) -> bool:
	var check_count = 0
	
	if border1_including:
		if value >= border1:
			check_count += 1
	else:
		if value > border1:
			check_count += 1
		
	if border2_including:
		if value <= border2:
			check_count += 1
	else:
		if value < border2:
			check_count += 1

	if check_count == 2:
			return true
		
	return false
	

## 'probability = 1' means 100%
## 'probability = 0' means 0%
## larger values are calculated as 1/probability
## return true in case probability is hit and false if not
static func evaluate_probability(probability: int) -> bool:
	if probability == 0:
		return false
	var random_spawner = randi() % probability
	if random_spawner == 0:
		return true
	
	return false


## the first value in the inner Arrays is the returned value
## the second value in the inner Arrays is the probability
## the last value should be 1.0.
## the function work also with every key value instead of integers
##
## example data:
#
#var weight_mapping = [
#	[0, 0.8],
#	[1, 0.9],
#	[2, 0.93],
#	[3, 0.95],
#	[4, 0.97],
#	[5, 1.0],
#]
static func rand_weight(weight_mapping: Array):
	var random_float = randf()

	for weight_pair in weight_mapping:
		if random_float <= weight_pair.back():
			return weight_pair.front()
	
	# just in case the weight map is not filled up to 1.0
	return weight_mapping.front().weight_pair.front()

## helper function to remove duplicate content from an Array
## the implementation creates a new Array which has only unique elements
static func array_unique(array: Array[Vector2]) -> Array[Vector2]:
	var unique: Array[Vector2] = []
	
	for item in array:
		if not unique.has(item):
			unique.append(item)

	return unique


static func get_all_files(path: String, file_ext := "", files := []) -> Array:
	var dir = DirAccess.open(path)

	if DirAccess.get_open_error() == OK:
		dir.list_dir_begin()

		var file_name = dir.get_next()

		while file_name != "":
			if dir.current_is_dir():
				files = get_all_files(dir.get_current_dir() +"/"+ file_name, file_ext, files)
			else:
				if file_ext and file_name.get_extension() != file_ext:
					file_name = dir.get_next()
					continue
				
				files.append(dir.get_current_dir() +"/"+ file_name)

			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access %s." % path)

	return files

static func enum_to_text(enum_type, enum_value: int) -> String:
	var keys = enum_type.keys()  # Direkt auf `keys()` zugreifen
	if enum_value < 0 or enum_value >= keys.size():
		push_error("Invalid enum value.")
		return ""
	return keys[enum_value]

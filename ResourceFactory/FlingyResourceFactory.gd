class_name FlingyResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := FlingyResource.new()
	
	resource.sprite = PackedInt32Array(data.sprite)
	resource.speed = PackedInt32Array(data.speed)
	resource.acceleration = PackedInt32Array(data.acceleration)
	resource.halt_distance = PackedInt32Array(data.halt_distance)
	resource.turn_radius = PackedInt32Array(data.turn_radius)
	resource.movement_control = PackedByteArray(data.movement_control)

	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

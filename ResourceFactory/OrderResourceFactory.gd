class_name OrderResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := OrderResource.new()

	resource.label = PackedInt32Array(data.label)
	resource.use_weapon_targeting = PackedByteArray(data.use_weapon_targeting)
	resource.interruptible = PackedByteArray(data.interruptible)
	resource.queueable = PackedByteArray(data.queueable)
	resource.targeting = PackedByteArray(data.targeting)
	resource.energy = PackedByteArray(data.energy)
	resource.animation = PackedByteArray(data.animation)
	resource.highlight = PackedInt32Array(data.highlight)
	resource.obscured_order = PackedByteArray(data.obscured_order)

	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

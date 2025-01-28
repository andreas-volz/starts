class_name SpriteResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := SpriteResource.new()
	
	resource.image = PackedInt32Array(data.image)
	resource.health_bar = PackedByteArray(data.health_bar)
	resource.is_visible = PackedByteArray(data.is_visible)
	resource.select_circle_image_size = PackedByteArray(data.select_circle_image_size)
	resource.select_circle_vertical_pos = PackedByteArray(data.select_circle_vertical_pos)

	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

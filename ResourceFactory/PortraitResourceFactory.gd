class_name PortraitResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := PortraitResource.new()
	
	resource.video_idle = PackedInt32Array(data.video_idle)
	resource.video_talking = PackedInt32Array(data.video_talking)
	resource.change_idle = PackedByteArray(data.change_idle)
	resource.change_talking = PackedByteArray(data.change_talking)
	
	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

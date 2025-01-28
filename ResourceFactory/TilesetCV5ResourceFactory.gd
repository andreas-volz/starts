class_name TilesetCV5ResourceFactory
extends RefCounted

func create_resource(input_file: String, output_dir: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var cv5_data: Array = json.data
	
	var tileset_cv5_resource := TilesetCV5Resource.new()
	
	# TODO: just all the complete json parsed data as it is to test the structure
	tileset_cv5_resource.elements = cv5_data

	var res_name := input_file.get_file().trim_suffix(".json")
	var resource_path = output_dir + "/" + res_name + ".tres"
	
	DirAccess.make_dir_recursive_absolute(resource_path.get_base_dir())
	var save_result = ResourceSaver.save(tileset_cv5_resource, resource_path)
	if save_result != OK:
		print("NOK: ", save_result)

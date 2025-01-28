class_name ChkResourceFactory
extends RefCounted

func create_resource(input_file: String, output_dir: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var chk_data: Dictionary = json.data
	
	var chk_resource := ChkResource.new()
	
	chk_resource.MTXM = chk_data.MTXM
	chk_resource.ERA = chk_data.ERA
	chk_resource.DIM = Vector2(chk_data.DIM.width, chk_data.DIM.height)

	var res_name := input_file.get_file().trim_suffix(".json")
	var resource_path = output_dir + "/" + res_name + ".tres"
	
	DirAccess.make_dir_recursive_absolute(resource_path.get_base_dir())
	var save_result = ResourceSaver.save(chk_resource, resource_path)
	if save_result != OK:
		print("NOK: ", save_result)

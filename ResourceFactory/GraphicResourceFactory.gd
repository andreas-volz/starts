class_name GraphicResourceFactory
extends RefCounted

func create_resource(prefix_path: String, input_file: String, output_dir: String):
	var absolute_input_file := prefix_path + "/" + input_file
	var json_string = FileAccess.get_file_as_string(absolute_input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", absolute_input_file)
		return

	var graphic_data: Dictionary = json.data
	
	var graphic_resource := GraphicResource.new()
	
	graphic_resource.width = graphic_data.width
	graphic_resource.height = graphic_data.height

	var res_name := input_file.trim_suffix(".json")
	
	var resource_path = output_dir + "/" + input_file.get_basename() + ".tres"
	
	DirAccess.make_dir_recursive_absolute(resource_path.get_base_dir())
	var save_result = ResourceSaver.save(graphic_resource, resource_path)
	if save_result != OK:
		print("NOK: ", save_result)

	# copy images as it's direct used by the resource loader
	var png_source = absolute_input_file.trim_suffix(".json") + ".png"
	var png_target = output_dir + "/" + input_file.trim_suffix(".json") + ".png"
	DirAccess.copy_absolute(png_source, png_target)

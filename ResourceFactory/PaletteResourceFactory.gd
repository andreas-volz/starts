class_name PaletteResourceFactory
extends RefCounted

func create_resource(input_file: String, output_dir: String):
	var rgb_array = read_rgb_array(input_file)
	
	var resource := PaletteResource.new()
	
	resource.colors = PackedByteArray(rgb_array)

	var res_name := input_file.get_file()
	var resource_path = output_dir + "/" + res_name + ".tres"
	
	DirAccess.make_dir_recursive_absolute(resource_path.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_path)
	if save_result != OK:
		print("NOK: ", save_result)

func read_rgb_array(file_path: String) -> Array[int]:
	var rgb_array: Array[int] = []
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file:
		while not file.eof_reached():
			# Read 3 bytes for RGB
			var red = file.get_8()
			rgb_array.push_back(red)
			if file.eof_reached(): break
			var green = file.get_8()
			rgb_array.push_back(green)
			if file.eof_reached(): break
			var blue = file.get_8()
			rgb_array.push_back(blue)
			
			# Append the RGB tuple to the array
			#rgb_array.append_array(Array(red, green, blue))
		
		file.close()
	else:
		push_error("Failed to open file: " + file_path)
	
	return rgb_array

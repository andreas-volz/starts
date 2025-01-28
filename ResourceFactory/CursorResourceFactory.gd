class_name CursorResourceFactory
extends RefCounted

func create_resource(input_file: String, output_dir: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var cursor_data: Array = json.data
	
	var spriteframes := SpriteFrames.new()
	
	spriteframes.add_animation("arrow")
	spriteframes.set_animation_loop("arrow", true)
	spriteframes.set_animation_speed("arrow", 10)

	var input_dir := input_file.get_base_dir()
	for frame in cursor_data:
		var cursor_image = Image.load_from_file(input_dir + "/" + frame)
		var cursor_texture = ImageTexture.create_from_image(cursor_image)
		spriteframes.add_frame("arrow", cursor_texture)

	var res_name := input_dir.get_file().trim_suffix(".json")
	var resource_path = output_dir + "/" + res_name + ".tres"
	
	DirAccess.make_dir_recursive_absolute(resource_path.get_base_dir())
	var save_result = ResourceSaver.save(spriteframes, resource_path)
	if save_result != OK:
		print("NOK: ", save_result)

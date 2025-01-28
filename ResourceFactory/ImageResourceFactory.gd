class_name ImageResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := ImageResource.new()
	
	resource.grp = PackedInt32Array(data.grp)
	resource.gfx_turns = PackedByteArray(data.gfx_turns)
	resource.clickable = PackedByteArray(data.clickable)
	resource.use_full_iscript = PackedByteArray(data.use_full_iscript)
	resource.draw_if_cloaked = PackedByteArray(data.draw_if_cloaked)
	resource.draw_function = PackedByteArray(data.draw_function)
	resource.remapping = PackedByteArray(data.remapping)
	resource.iscript = PackedInt32Array(data.iscript)
	resource.shield_overlay = PackedInt32Array(data.shield_overlay)
	resource.attack_overlay = PackedInt32Array(data.attack_overlay)
	resource.damage_overlay = PackedInt32Array(data.damage_overlay)
	resource.special_overlay = PackedInt32Array(data.special_overlay)
	resource.landing_dust_overlay = PackedInt32Array(data.landing_dust_overlay)
	resource.lift_off_dust_overlay = PackedInt32Array(data.lift_off_dust_overlay)
	

	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

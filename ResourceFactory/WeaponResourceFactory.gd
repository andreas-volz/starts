class_name WeaponResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := WeaponResource.new()
	
	resource.label = PackedInt32Array(data.label)
	resource.flingy = PackedInt32Array(data.flingy)
	
	resource.explosion = PackedByteArray(data.explosion)
	resource.target_flags = PackedInt32Array(data.target_flags)
	resource.minimum_range = PackedInt32Array(data.minimum_range)
	resource.maximum_range = PackedInt32Array(data.maximum_range)
	resource.damage_upgrade = PackedByteArray(data.damage_upgrade)
	resource.weapon_type = PackedByteArray(data.weapon_type)
	resource.weapon_behaviour = PackedByteArray(data.weapon_behaviour)
	resource.remove_after = PackedByteArray(data.remove_after)
	resource.explosive_type = PackedByteArray(data.explosive_type)
	resource.inner_splash_range = PackedInt32Array(data.inner_splash_range)
	resource.medium_splash_range = PackedInt32Array(data.medium_splash_range)
	resource.outer_splash_range = PackedInt32Array(data.outer_splash_range)
	resource.damage_amount = PackedInt32Array(data.damage_amount)
	resource.damage_bonus = PackedInt32Array(data.damage_bonus)
	resource.weapon_cooldown = PackedByteArray(data.weapon_cooldown)
	resource.damage_factor = PackedByteArray(data.damage_factor)
	resource.attack_angle = PackedByteArray(data.attack_angle)
	resource.launch_spin = PackedByteArray(data.launch_spin)
	resource.x_offset = PackedByteArray(data.x_offset)
	resource.y_offset = PackedByteArray(data.y_offset)
	resource.error_message = PackedInt32Array(data.error_message)
	resource.icon = PackedInt32Array(data.icon)

	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

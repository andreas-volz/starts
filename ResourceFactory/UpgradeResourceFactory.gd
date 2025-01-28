class_name UpgradeResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := UpgradeResource.new()
	
	resource.mineral_cost_base = PackedInt32Array(data.mineral_cost_base)
	resource.mineral_cost_factor = PackedInt32Array(data.mineral_cost_factor)
	resource.vespene_cost_base = PackedInt32Array(data.vespene_cost_base)
	resource.vespene_cost_factor = PackedInt32Array(data.vespene_cost_factor)
	resource.research_time_base = PackedInt32Array(data.research_time_base)
	resource.research_time_factor = PackedInt32Array(data.research_time_factor)
	resource.icon = PackedInt32Array(data.icon)
	resource.label = PackedInt32Array(data.label)
	resource.race = PackedByteArray(data.race)
	resource.max_repeats = PackedByteArray(data.max_repeats)

	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

class_name TechResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := TechResource.new()
	
	resource.mineral_cost = PackedInt32Array(data.mineral_cost)
	resource.vespene_cost = PackedInt32Array(data.vespene_cost)
	resource.research_time = PackedInt32Array(data.research_time)
	resource.energy_required = PackedInt32Array(data.energy_required)
	resource.icon = PackedInt32Array(data.icon)
	resource.label = PackedInt32Array(data.label)
	resource.race = PackedByteArray(data.race)
	
	# TODO: Broodwar logic
	#resource.broodwar_flag = PackedByteArray(data.broodwar_flag)
	#resource.has_broodwar_flag = data.has_broodwar_flag
	

	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

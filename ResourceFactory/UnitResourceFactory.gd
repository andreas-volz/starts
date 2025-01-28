class_name UnitResourceFactory
extends RefCounted

func create_resource(input_file: String, resource_file: String):
	var json_string = FileAccess.get_file_as_string(input_file)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line(), " in file ", input_file)
		return

	var data: Dictionary = json.data
	
	var resource := UnitResource.new()
	
	resource.flingy = PackedByteArray(data.flingy)
	resource.subunit1 = PackedInt32Array(data.subunit1)
	resource.infestation = PackedInt32Array(data.infestation)
	resource.construction_animation = PackedInt32Array(data.construction_animation)
	resource.unit_direction = PackedByteArray(data.unit_direction)
	resource.shield_enable = PackedByteArray(data.shield_enable)
	resource.shield_amount = PackedInt32Array(data.shield_amount)
	resource.hit_points = PackedInt32Array(data.hit_points)
	resource.elevation_level = PackedByteArray(data.elevation_level)
	resource.rank = PackedByteArray(data.rank)
	resource.ai_computer_idle = PackedByteArray(data.ai_computer_idle)
	resource.ai_human_idle = PackedByteArray(data.ai_human_idle)
	resource.ai_return_to_idle = PackedByteArray(data.ai_return_to_idle)
	resource.ai_attack_unit = PackedByteArray(data.ai_attack_unit)
	resource.ai_attack_move = PackedByteArray(data.ai_attack_move)
	resource.ground_weapon = PackedByteArray(data.ground_weapon)
	#resource.max_ground_hits = PackedByteArray(data.max_ground_hits)
	resource.air_weapon = PackedByteArray(data.air_weapon)
	#resource.max_air_hits = PackedByteArray(data.max_air_hits)
	resource.ai_internal = PackedByteArray(data.ai_internal)
		
	var special_ability_flags_array: Array
	for special_ability_flags in data.special_ability_flags:
		var new_special_ability_flags: Array = []
		new_special_ability_flags.push_back(special_ability_flags.building)
		new_special_ability_flags.push_back(special_ability_flags.addon)
		new_special_ability_flags.push_back(special_ability_flags.flyer)
		new_special_ability_flags.push_back(special_ability_flags.resourceminer)
		new_special_ability_flags.push_back(special_ability_flags.subunit)
		new_special_ability_flags.push_back(special_ability_flags.flyingbuilding)
		new_special_ability_flags.push_back(special_ability_flags.hero)
		new_special_ability_flags.push_back(special_ability_flags.regenerate)
		new_special_ability_flags.push_back(special_ability_flags.animatedidle)
		new_special_ability_flags.push_back(special_ability_flags.cloakable)
		new_special_ability_flags.push_back(special_ability_flags.twounitsinoneegg)
		new_special_ability_flags.push_back(special_ability_flags.singleentity)
		new_special_ability_flags.push_back(special_ability_flags.resourcedepot)
		new_special_ability_flags.push_back(special_ability_flags.resourcecontainter)
		new_special_ability_flags.push_back(special_ability_flags.robotic)
		new_special_ability_flags.push_back(special_ability_flags.detector)
		new_special_ability_flags.push_back(special_ability_flags.organic)
		new_special_ability_flags.push_back(special_ability_flags.requirescreep)
		new_special_ability_flags.push_back(special_ability_flags.unused)
		new_special_ability_flags.push_back(special_ability_flags.requirespsi)
		new_special_ability_flags.push_back(special_ability_flags.burrowable)
		new_special_ability_flags.push_back(special_ability_flags.spellcaster)
		new_special_ability_flags.push_back(special_ability_flags.permanentcloak)
		new_special_ability_flags.push_back(special_ability_flags.pickupitem)
		new_special_ability_flags.push_back(special_ability_flags.ignoresupplycheck)
		new_special_ability_flags.push_back(special_ability_flags.usemediumoverlays)
		new_special_ability_flags.push_back(special_ability_flags.uselargeoverlays)
		new_special_ability_flags.push_back(special_ability_flags.battlereactions)
		new_special_ability_flags.push_back(special_ability_flags.fullautoattack)
		new_special_ability_flags.push_back(special_ability_flags.invincible)
		new_special_ability_flags.push_back(special_ability_flags.mechanical)
		new_special_ability_flags.push_back(special_ability_flags.producesunits)
		# push all into the array
		special_ability_flags_array.push_back(new_special_ability_flags)
	var packed_special_ability_flags := BitUtils.create_packed_int32_array_from_booleans(special_ability_flags_array)
	resource.special_ability_flags = packed_special_ability_flags

	resource.target_acquisition_range = PackedByteArray(data.target_acquisition_range)
	resource.sight_range = PackedByteArray(data.sight_range)
	resource.armor_upgrade = PackedByteArray(data.armor_upgrade)
	resource.unit_size = PackedByteArray(data.unit_size)
	resource.armor = PackedByteArray(data.armor)
	resource.right_click_action = PackedByteArray(data.right_click_action)
	resource.ready_sound = PackedInt32Array(data.ready_sound)
	resource.what_sound_start = PackedInt32Array(data.what_sound_start)
	resource.what_sound_end = PackedInt32Array(data.what_sound_end)
	resource.piss_sound_start = PackedInt32Array(data.piss_sound_start)
	resource.piss_sound_end = PackedInt32Array(data.piss_sound_end)
	resource.yes_sound_start = PackedInt32Array(data.yes_sound_start)
	resource.yes_sound_end = PackedInt32Array(data.yes_sound_end)
		
	var unit_dimension_array: Array
	for unit_dimension in data.unit_dimension:
		var new_unit_dimension: Array = []
		new_unit_dimension.push_back(unit_dimension.left)
		new_unit_dimension.push_back(unit_dimension.up)
		new_unit_dimension.push_back(unit_dimension.right)
		new_unit_dimension.push_back(unit_dimension.down)
		unit_dimension_array.push_back(new_unit_dimension)
	var packed_unit_dimension := BitUtils.create_packed_int64_array_from_int16(unit_dimension_array)
	resource.unit_dimension = packed_unit_dimension
	
	resource.portrait = PackedInt32Array(data.portrait)
	resource.mineral_cost = PackedInt32Array(data.mineral_cost)
	resource.vespene_cost = PackedInt32Array(data.vespene_cost)
	resource.build_time = PackedInt32Array(data.build_time)
	
	var group_flags_array: Array
	for group_flags in data.group_flags:
		var new_group_flags: Array = []
		new_group_flags.push_back(group_flags.building)
		new_group_flags.push_back(group_flags.factory)
		new_group_flags.push_back(group_flags.independent)
		new_group_flags.push_back(group_flags.men)
		new_group_flags.push_back(group_flags.neutral)
		new_group_flags.push_back(group_flags.protoss)
		new_group_flags.push_back(group_flags.terran)
		new_group_flags.push_back(group_flags.zerg)
		# push all into the array
		group_flags_array.push_back(new_group_flags)
	var packed_group_flags := BitUtils.create_packed_byte_array_from_booleans(group_flags_array)
	resource.group_flags = packed_group_flags
	
	resource.supply_provided = PackedByteArray(data.supply_provided)
	resource.supply_required = PackedByteArray(data.supply_required)
	resource.space_provided = PackedByteArray(data.space_provided)
	resource.space_required = PackedByteArray(data.space_required)
	resource.build_score = PackedInt32Array(data.build_score)
	resource.destroy_score = PackedInt32Array(data.destroy_score)
	resource.is_format_bw = data.is_format_bw
	if resource.is_format_bw:
		resource.broodwar_flag = PackedByteArray(data.broodwar_flag)
	
	
	DirAccess.make_dir_recursive_absolute(resource_file.get_base_dir())
	var save_result = ResourceSaver.save(resource, resource_file)
	if save_result != OK:
		print("NOK: ", save_result)

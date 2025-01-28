class_name IScriptResourceFactory
extends RefCounted

const ANIMATION_STEP: float = 0.1 # GRP specified frame length

func create_resource(input_file: String, resource_file: String):
	var file = FileAccess.open(input_file, FileAccess.READ)
	if file == null:
		push_error("Could not open file: ", input_file)
		return
		
	var iscript_resource = IScriptResource.new()

	var current_animation_list: Array
	var current_iscript: int = -1
	
	var in_header := false
	var in_opcode := false
	
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
	
		# Parse header section
		if line == ".headerstart":
			in_header = true
			current_animation_list = []
		elif line == ".headerend":
			in_header = false
			# store animation headers in Dictionary with iscript id
			if current_iscript >= 0:
				iscript_resource.animation_header_dict[current_iscript] = current_animation_list
		elif in_header:
			var parts = line.split(":")
			if parts.size() == 2:
				var key = parts[0].strip_edges()
				
				if key == "iscript":
					var stripped = parts[1].strip_edges()
					var value: int = int(stripped)
					current_iscript = value
				elif key == "animations":
					# read elements from second part and cast to int type
					current_animation_list = Array(parts[1].strip_edges().split(" ", false)).map(func(element): return int(element))
	
		elif line == ".opcodestart":
			in_opcode = true
		elif line == ".opcodeend":
			in_opcode = false
	
		elif in_opcode:
			var parts: Array = Array(line.split(" ")).map(func(element): return int(element))
			if parts.size() > 0:
				iscript_resource.opcode_list.push_back(parts)
				
	file.close()
	
	var resource_path = resource_file
	
	DirAccess.make_dir_recursive_absolute(resource_path.get_base_dir())
	var save_result = ResourceSaver.save(iscript_resource, resource_path)
	if save_result != OK:
		print("NOK: ", save_result)

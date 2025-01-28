class_name IScriptProc
extends Node

signal move(relative: Vector2)
signal imgul(image_id: int, pos: Vector2i)
signal imgol(image_id: int, pos: Vector2i)
#signal followmaingraphic

var _resource_manager: ResourceManager
var _iscript_id: int

const WAIT_TIME_TICK := 0.1 # process_iscript_frame() at 10ms * WAIT step
var iscript_wait_time: float = 0.0 # the iscript WAIT logic changes this to wait some time
var delta_iscript_t: float = 0.0
var opcode_index = 0
var current_animation_type: IScript.AnimationType = -1

var playfram: int
var followmaingraphic: bool = false

var is_init = false
var first_playfram = false

func _init(resource_manager: ResourceManager, iscript_id: int):
	_resource_manager = resource_manager
	_iscript_id = iscript_id
		
	if not _resource_manager.iscript.animation_header_dict.has(iscript_id):
		push_error("request unavailable iscript: ", iscript_id)
		return
		
func _process(delta: float) -> void:
	delta_iscript_t += delta
		
	if delta_iscript_t >= iscript_wait_time:
		iscript_wait_time = 0
		process_iscript_frame()
		delta_iscript_t = 0

func play(animation_type: IScript.AnimationType):
	# do not change any running animation to the same again
	if current_animation_type == animation_type:
		return
	
	# process Init, but don't init twice
	if animation_type == IScript.AnimationType.Init:
		if is_init:
			return
		else:
			is_init = true
		
	# final check init state or return
	if not is_init:
		return
		
	if not _resource_manager.iscript.animation_header_dict.has(_iscript_id):
		push_error("request unavailable iscript: ", _iscript_id)
		return
		
	var animation_header: Array[IScript.AnimationType] = _resource_manager.iscript.animation_header_dict[_iscript_id]
	
	if animation_header.size() > animation_type:
		opcode_index = animation_header[animation_type]
		#print("opcode_index: ", opcode_index)
	else:
		push_error("request unavailable animation: ", animation_type)

	# remember current running animation to not start it again and again
	current_animation_type = animation_type

	# this triggers to abort the current iscript WAIT command and go to the next command
	# TODO: the NOBRKCODESTART and NOBRKCODEEND command might be implemented in combination
	iscript_wait_time = 0
	

func process_iscript_frame():
	var opcode: IScript.Opcode = _resource_manager.iscript.opcode_list[opcode_index]
	#print("opcode.code: ", opcode.code)
	#print("")

	# TODO: this could be done with match or if/else. no need to check all with if every frame
	
	if opcode.code == IScript.opcode_t.IMGUL:
		var image_arg = opcode.args[0]
		var x_arg = opcode.args[1]
		var y_arg = opcode.args[2]
		imgul.emit(image_arg, Vector2i(x_arg, y_arg))
		#print("IMGUL")
		
	if opcode.code == IScript.opcode_t.IMGOL:
		var image_arg = opcode.args[0]
		var x_arg = opcode.args[1]
		var y_arg = opcode.args[2]
		imgol.emit(image_arg, Vector2i(x_arg, y_arg))
		
	if opcode.code == IScript.opcode_t.PLAYFRAM:
		playfram = opcode.args[0]
		first_playfram = true
		#print("opcode PLAYFRAM: ", playfram)
	
	if opcode.code == IScript.opcode_t.WAIT:
		iscript_wait_time = opcode.args[0] * WAIT_TIME_TICK
		pass
	
	if opcode.code == IScript.opcode_t.WAITRAND:
		var ticks1 = opcode.args[0]
		var ticks2 = opcode.args[1]
		var ticks_rand = randi_range(ticks1, ticks2)
		iscript_wait_time = ticks_rand * WAIT_TIME_TICK
	
	if opcode.code == IScript.opcode_t.MOVE:
		var movedistance = opcode.args[0]
		var direction_vector: Vector2 = PathFinderGrid.DIRECTION_VECTORS[get_parent().direction]
		
		# multiply the normalized direction with the unit "speed" to get the real movement step
		var normalized_move_vector = direction_vector.normalized() * movedistance
		move.emit(normalized_move_vector)
		
	if opcode.code == IScript.opcode_t.FOLLOWMAINGRAPHIC:
		followmaingraphic = true
		#first_playfram = true
		#print("IScript.opcode_t.FOLLOWMAINGRAPHIC")
		
	if opcode.code == IScript.opcode_t.END:
		pass # later remove graphic
	
	# change to next opcode index below
	if opcode.code == IScript.opcode_t.GOTO:
		opcode_index = opcode.args[0]
	else:
		# each process step increases the opcode index ... if not jumped anywhere else
		opcode_index += 1
	
	
	

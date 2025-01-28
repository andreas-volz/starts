class_name Unit
extends Node2D

@export var unit_type: int = -1

@export var direction: PathFinderGrid.Directions : set=set_direction

# remember current Unit cell Minitile position
var _cell: Vector2i
var _path: PackedVector2Array
var _cell_manager: CellManager
var _resource_manager: ResourceManager

var flingy_target: Vector2i: set=set_flingy_target

# in case the naviation path and walking is not aligned or somehow bad activate both to debug the problem
var debug_navigation_path := true # draw a navigation line for debugging purposes
var debug_move_path := false # draw the real walked path for debugging purposes

# there's my sepcial showroom mode where units walk on the place
var showroom_mode := false

var star_unit: StarUnit

@onready var unit_selection: UnitSelection = $UnitSelection
@onready var navigation_path: Line2D = %NavigationPath
@onready var move_path: Line2D = %MovePath

func init_resources(resource_manager: ResourceManager, cell_manager: CellManager) -> void:
	_cell_manager = cell_manager
	_resource_manager = resource_manager
	
	
	#$IScriptNode.flingy_move.connect(_on_flingy_move)
	
func load_id(unit_type: int):
	star_unit = StarUnit.new(_resource_manager)
	star_unit.load_id(unit_type)
	add_child(star_unit)
	
	star_unit._star_flingy._star_main_sprite._star_main_image.iscript_proc.move.connect(_on_iscript_move)
	
	# get the correct circle image for selection
	var dat_sprite := star_unit._star_flingy._star_main_sprite.get_dat()
	var dat_circle_image := dat_sprite.select_circle_image_size_obj()
	var circle_grp := dat_circle_image.grp_tbl().name1()
	
	# TODO: just draw a debug circle until the StarImage logic works correct
	var circle_size_str := circle_grp.get_file().get_basename().right(-1)
	var circle_size := int(circle_size_str)
	
	# some magic to calculate the vertical position based on the specs.
	# TODO: need to verify this with the real image circles
	var graphic_resource := star_unit._star_flingy._star_main_sprite._star_main_image.graphic_resource
	var input_height := dat_sprite.select_circle_vertical_pos()
	var remapped_vertical = remap(input_height, 0, 255, 0, graphic_resource.height*2)
	remapped_vertical = wrapi(remapped_vertical, -graphic_resource.height, graphic_resource.height)
	
	print("vert: ", dat_sprite.select_circle_vertical_pos())
	print("remap: ", remapped_vertical)
	
	$UnitSelection.circle_size = circle_size
	$UnitSelection.position.y = remapped_vertical
	#print(circle_size)
	
func set_team_color(color_index: int):
	pass
	#$IScriptNode.set_team_color(color_index)
	
func get_max_directions() -> int:
	return 8
	#return $IScriptNode.max_directions
		
func play_animation(animation: IScript.AnimationType):
	star_unit.play(animation)
		
func set_flingy_target(target: Vector2i):
	flingy_target = target
	#$IScriptNode.set_flingy_target(target)
		
# put a Unit into a cell. not walking, no animation, just jump there
func set_cell(minitile_cell):
	_cell = minitile_cell
	#flingy_target = _cell
	global_position = MapManager.calculate_map_to_world(minitile_cell)
	
func set_direction(direction_param: int):
	direction = direction_param
	star_unit.set_direction(direction)
	#print("direction: ", direction_param)
	#$IScriptNode.direction = direction_param

func set_selection(value: bool) -> void:
	unit_selection.visible = value

func set_navigation_path(path: PackedVector2Array):
	_path = path
	iterate_navigation_path()
	if debug_navigation_path:
		if not path.is_empty():
			draw_navigation_path()
		
func iterate_navigation_path():
	if _path.size() >= 2:
		var node0: Vector2i = _path[0]
		var node1: Vector2i = _path[1]
		var delta_x = node1.x - node0.x
		var delta_y = node1.y - node0.y
		
		# add PI/2 because the zero position of the unit is up north and right rotation
		var rad_next: float = atan2(delta_y, delta_x) + PI/2.0 
		rad_next = wrapf(rad_next, 0, 2*PI)

		#print("rad_next: ", rad_next)
		#print("deg_next:" , rad_to_deg(rad_next))
		
		# calculate the next direction on the path and the Unit should rotate to that direction
		var direction_next: int = rad_next / ((2*PI) / 8.0)
		
		if direction_next != direction:
			# everytime the direction is changed correct the exact position to the middle of the current cell
			# without this correction the Unit will loose the path after some time
			global_position = MapManager.calculate_map_to_world(node0)
		
		direction = direction_next
		#print("next direction: ", direction_next)
		
		# remove the first path point
		_path.remove_at(0)
		
		star_unit.play(IScript.AnimationType.Walking)
	elif _path.size() < 2:
		star_unit.play(IScript.AnimationType.WalkingToIdle)
		
func draw_navigation_path():
	navigation_path.clear_points()
	for coord in _path:
		navigation_path.add_point(MapManager.calculate_map_to_world(coord))
		
func draw_move_path(point: Vector2):
	move_path.add_point(point)
		
func _on_flingy_move(relative: Vector2):
	if showroom_mode:
		return
		
	var old_cell := _cell
	var new_position := global_position + relative
	var new_cell := MapManager.calculate_world_to_map(new_position)
	
	global_position = new_position
		
	if old_cell != new_cell:
		var move_ok: bool = _cell_manager.move_item(old_cell, new_cell)
		if move_ok:
			_cell = new_cell
			
		
func _on_iscript_move(relative: Vector2):
	if showroom_mode:
		return
		
	var old_cell := _cell
	var new_position := global_position + relative
	var new_cell := MapManager.calculate_world_to_map(new_position)
	
	global_position = new_position
	
	if debug_move_path:
		draw_move_path(global_position)
	
	if old_cell != new_cell:
		var move_ok: bool = _cell_manager.move_item(old_cell, new_cell)
		if move_ok:
			_cell = new_cell
			
			if _path.size() > 0:
				iterate_navigation_path()

	

		

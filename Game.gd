extends Node2D

const UNIT = preload("res://Unit.tscn")

var cell_manager: CellManager = CellManager.new()
var map_manager:  MapManager = MapManager.new()
var resource_manager: ResourceManager = ResourceManager.new()

var _current_unit_cell: Vector2 = Vector2.INF
var _current_unit
var _walkable_cells: Dictionary

@onready var units_container: Node2D = $UnitsContainer
@onready var map_container: Node2D = $MapContainer
@onready var game_ui_console: NinePatchRect = %GameUIConsole
@onready var portrait_video_player: PortraitVideoPlayer = %PortraitVideoPlayer
@onready var cmd_btns_grid: CommandBtnsGrid = %CmdBtnsGrid
@onready var wireframe: Wireframe = %Wireframe
@onready var selection_box: Node2D = $SelectionBox
@onready var unit_tile_map: TileMapLayer = $UnitTileMap

func _init() -> void:
	pass
	
	set_cursor("arrow")
	
func _ready() -> void:
	Events.cell_clicked.connect(_on_cell_clicked)
	Events.cell_clicked_right.connect(_on_cell_clicked_right)
	Events.cell_hovered.connect(_on_cell_hovered)
	selection_box.select_rect.connect(_on_select_rect)
	
	portrait_video_player._init_resources(resource_manager)
	game_ui_console.init_resources(resource_manager)
	game_ui_console.set_race("terran")
	
	cmd_btns_grid._init_resources(resource_manager)
	
	wireframe._init_resources(resource_manager)
	wireframe.load_texture(Wireframe.WireframeType.STANDARD)
	wireframe.visible = false
		
	var unit
	# *4 because place a unit on a Megatile coordinate to test the code below, later in Chk is the Minitile position
	unit = create_unit(106, Vector2i(30, 42) * 4)
	unit = create_unit(0, Vector2i(30, 46) * 4)
	unit = create_unit(3, Vector2i(30, 47) * 4)
	unit = create_unit(15, Vector2i(25, 40) * 4)
	unit = create_unit(32, Vector2i(40, 25) * 4)
	
	#create_units_test()
		
	var map_name: String = "campaign_terran_terran02"
	var tmj_file = resource_manager.starts_resources_path + "campaign/" + map_name + ".tmj"
	
	var importer_module = preload("res://YATI/runtime/Importer.gd").new()
	var added_node = importer_module.import(tmj_file)
	var map_size = added_node.get_used_rect().size

	map_manager.init_resources(resource_manager, map_name)

	map_container.add_child(added_node.duplicate())
	
	
# TODO: this is a fast implementation to choose a cursor, but if I give a wrong resource -> crash
func set_cursor(type: String):
	var sprite_frames = ResourceLoader.load(resource_manager.starts_resources_path + "cursor/" + type + ".tres")
	Cursor.sprite.sprite_frames = sprite_frames
	Cursor.set_shape(Cursor.Shapes.CURSOR_ARROW)
	Cursor.sprite.set_offset(Vector2(63, 63)) # TODO: read this in by some configuration file
	
func create_units_test():
	var unit: Unit
	var i := 0
	var distance := 4
	var offset := 5
	# TODO: just generate the first ~100 units as test. later units are broken as they are from thingy graphics and those have remapping names which aren't yet found...
	for x in range(14):
		for y in range(14):
			unit = create_unit(i, Vector2i(offset + x * distance, offset + y * distance) * 4) #unit-terran-marine
			i += 1

## @param cell in Minitile coordinates
func create_unit(unit_type: int, cell: Vector2i):
	var unit = UNIT.instantiate()
	#var unit: StarUnit = StarUnit.new(resource_manager)
	unit.init_resources(resource_manager, cell_manager)
	unit.load_id(unit_type)
		
	# add unit to scene and position it
	units_container.add_child(unit)
	
	unit.set_cell(cell)
	
	cell_manager.add_item(cell, unit)
	
	#unit.play_animation(IScript.AnimationType.Init)
	
	unit.star_unit.set_team_color(1)
	
	#unit._cell = cell
	#unit.set_team(team)
	#unit.select(false)
	
	return unit

func calculate_path_to(cell: Vector2) -> PackedVector2Array:
	if _current_unit:
		_current_unit_cell = _current_unit._cell
	
	if _current_unit_cell == Vector2.INF:
		#unit_tile_map.stop()
		return PackedVector2Array()
		
	var unit = cell_manager.get_item(_current_unit_cell)
	if unit == null:# or unit.is_moving() or unit.is_attacking():
		return PackedVector2Array()
	
	var cell_start = _current_unit_cell
	var cell_end = cell
	
	
	# TBD: remove other units from possible walking cells depending on game logic. 
	#var walkable_cells_filtered = _remove_units_walkable(_walkable_cells)
	
	map_manager.initialize()
	var current_path = map_manager.calculate_path(cell_start, cell_end)
	#print("draw path: " + str(cell_start) + " -> " + str(cell_end))
	 
	return current_path

func _on_cell_hovered(cell: Vector2i):
	#print("_on_cell_hovered: ", cell)
	var occupied: bool = cell_manager.is_occupied(cell)
	if occupied:
		set_cursor("magg")
	else:
		set_cursor("arrow")

func _on_cell_clicked(cell: Vector2i):
	
	# check if the clicked cell is on the board
	# TODO: here it should check later if a cell is walkable
	#if not unit_tile_map.get_used_cells_array().has(cell):
		#return	
		
	# first check if there's a unit on the clicked cell
	var select_unit = cell_manager.get_item(cell)
	if select_unit:
		# if one is found deselect all others and chose that unit
		deselect_all_units()
		select_unit.set_selection(true)
		_current_unit_cell = cell
		_current_unit = select_unit
		portrait_video_player.play_portrait(_current_unit.star_unit.get_dat())
		wireframe.set_colortype(Wireframe.ColorType.WIREFRAME)
		wireframe.set_health(1.0, 0.0)
		wireframe.frame = _current_unit.star_unit.get_dat().get_id()
		wireframe.visible = true


func _on_cell_clicked_right(cell: Vector2i):
	# if no unit is found on the clicked cell start start action (move, fight...) if one unit was selected before
	# only able to move own units
	#if current_unit.team == _team:
	if _current_unit:
		if _current_unit.star_unit.get_dat().flingy_obj().movement_control() == DatFlingy.movement_control_enum_t.MOVEMENT_CONTROL_ENUM_ISCRIPT:
			move_unit(_current_unit, cell)
		else:
			#print("move flingy")
			_current_unit.set_flingy_target(cell)
		
func move_unit(unit, cell: Vector2i):
	var current_path := calculate_path_to(cell)
	unit.set_navigation_path(current_path)
	
func deselect_all_units():
	for unit in cell_manager.values():
		pass
		unit.set_selection(false)

func _on_select_rect(start_pos: Vector2, end_pos: Vector2):
	
	var start_cell = unit_tile_map.calculate_world_to_map(start_pos)
	var end_cell = unit_tile_map.calculate_world_to_map(end_pos)
	
	var items_array: Array = cell_manager.get_items_rect(start_cell, end_cell)
	#print(items_array.size())
	if not items_array.is_empty():
		deselect_all_units()
		for select_unit in items_array:
			select_unit.set_selection(true)
		
		_current_unit = items_array.front()
		portrait_video_player.play_portrait(_current_unit.star_unit.get_dat())
		wireframe.set_colortype(Wireframe.ColorType.WIREFRAME)
		wireframe.set_health(1.0, 0.0)
		wireframe.frame = _current_unit.star_unit.get_dat().get_id()
		wireframe.visible = true

class_name MapManager
extends RefCounted

# This variable holds a reference to a PathFinder object. We'll create a new one every time the 
# player select a unit.
var _pathfinder: PathFinderGrid
var _map_size: Vector2i

var unwalkable_cells: Array[Vector2i] = []

# Creates a new PathFinder that uses the AStar algorithm we use to find a path between two cells 
# among the `walkable_cells`.
# We'll call this function every time the player selects a unit.
func initialize() -> void:
	_pathfinder = PathFinderGrid.new(_map_size)
	#print("unwalkable_cells: ", unwalkable_cells)

	#var i := 0
	for cell in unwalkable_cells:
		_pathfinder.set_unwalkable_cell(cell)
		#i += 1
	#print("_pathfinder unwalkable cells: ", i)
	
func init_resources(resource_manager: ResourceManager, map_name: String) -> void:

	var chk_path: String = resource_manager.starts_resources_path + "campaign/"
	var chk_resource: ChkResource = ResourceLoader.load(chk_path + map_name + "_chk.tres")
	_map_size = chk_resource.DIM
	var tileset_name: String = chk_resource.ERA
	
	var cv5_path: String = resource_manager.starts_resources_path + "tileset/cv5/"
	var tileset_cv5_resource: TilesetCV5Resource = ResourceLoader.load(cv5_path + tileset_name + "_cv5.tres")

	var vf4_path: String = resource_manager.starts_resources_path + "tileset/vf4/"
	var tileset_vf4_resource: TilesetVF4Resource = ResourceLoader.load(vf4_path + tileset_name + "_vf4.tres")
	
	var num_walkable_cells := 0
	var num_unwalkable_cells := 0
		
	var i := 0
	for tile: int in chk_resource.MTXM:
		var groupIndex = (tile & 0x7FF0) >> 4;
		var tileIndex = tile & 0x000F;
		
		var cv5_element = tileset_cv5_resource.elements[groupIndex]
		var vf4_index = cv5_element.vx4_vf4_ref[tileIndex]
		#print("megatile_ref: ", megatile_ref)
		var vf4_flags: Array = tileset_vf4_resource.elements[vf4_index]

		var x = i % _map_size.x
		var y = i / _map_size.y
		var cell := Vector2i(x, y)

		var n: = 0
		for flag in vf4_flags:
			var walkable_flag = flag.walkable
			var x2 = n % 4
			var y2 = n / 4
			var cell2 := Vector2i(x2, y2)
			#print("cell2: ", cell2)
			var cell_minitile = cell*4 + cell2
			#print("cell_minitile: ", cell_minitile)
			#if minitile == true:
			if walkable_flag == false:
				unwalkable_cells.append(cell_minitile)
				#print("unwalkable: ", cell_minitile)
				num_unwalkable_cells += 1
			else:
				num_walkable_cells += 1
				#print("walkable: ", cell_minitile)
			n += 1
		
		i += 1
		
	#print("unwalkable_cells: ", unwalkable_cells)
	#print("num_walkable_cells: ", num_walkable_cells)
	#print("num_unwalkable_cells: ", num_unwalkable_cells)
	#print("all cells num: ", num_walkable_cells + num_unwalkable_cells)
#
	#print("debug_point")
	
func calculate_path(cell_start: Vector2, cell_end: Vector2) -> PackedVector2Array:
	var current_path := _pathfinder.get_point_path(cell_start, cell_end)
	return current_path
	
static func calculate_map_to_world(coord: Vector2) -> Vector2:
	return coord * 8.0 + Vector2(4, 4) # one Minitile is 8 pixels in each direction and + 4 as it should position the unit in the middle
	
static func calculate_world_to_map(coord: Vector2) -> Vector2i:
	return coord / 8.0  # one Minitile is 8 pixels in each direction

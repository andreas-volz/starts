class_name PathFinderGrid
extends RefCounted

const DIRECTION_WEST = Vector2i(-1, 0)
const DIRECTION_EAST = Vector2i(1, 0)
const DIRECTION_NORTH = Vector2i(0, -1)
const DIRECTION_SOUTH = Vector2i(0, 1)
const DIRECTION_NORTHWEST = Vector2i(-1, -1)
const DIRECTION_NORTHEAST = Vector2i(1, -1)
const DIRECTION_SOUTHWEST = Vector2i(-1, 1)
const DIRECTION_SOUTHEAST = Vector2i(1, 1)

enum Directions {
	NORTH,
	NORTHEAST,
	EAST,
	SOUTHEAST,
	SOUTH,
	SOUTHWEST,
	WEST,
	NORTHWEST
}
const DIRECTION_VECTORS = [DIRECTION_NORTH, DIRECTION_NORTHEAST, DIRECTION_EAST, DIRECTION_SOUTHEAST, DIRECTION_SOUTH, DIRECTION_SOUTHWEST, DIRECTION_WEST, DIRECTION_NORTHWEST]

const CELL_SIZE = Vector2(1, 1) # TODO: (1, 1) gives me a result path with grid coordinates, (8, 8) gives me world coordinates. Which is better?

var _astar := AStarGrid2D.new()

func _init(map_size: Vector2i) -> void:
	_astar.region = Rect2i(Vector2i(0, 0), map_size * 4) # Map dimmension Vector2i * 4 => because 4x4 Minitiles give one Megatile
	_astar.cell_size = CELL_SIZE
	var heuristic = AStarGrid2D.HEURISTIC_MANHATTAN # MANHATTAN is better for long ways, OCTILE for bridges,... hmmmm
	_astar.default_compute_heuristic = heuristic
	_astar.default_estimate_heuristic = heuristic
	_astar.update()
	
func get_point_path(start: Vector2i, end: Vector2i) -> PackedVector2Array:
	return _astar.get_point_path(start, end, true) # allow also partial path to nearest point
	# TODO: partial path to a not reaching point works only in case the end point is a valid walkable terrain,
	# but placed on an island or high area. If end point is water or creep than no path is calculated
	# https://github.com/godotengine/godot-proposals/issues/277

func set_unwalkable_cell(id: Vector2i):
	_astar.set_point_solid(id, true)

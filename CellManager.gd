class_name CellManager
extends RefCounted

# We use a dictionary to keep track of the units that are on the board. Each key-value pair in the
# dictionary represents a unit. The key is the position in grid coordinates, while the value is a
# reference to the unit.
# Mapping of coordinates of a cell to a reference to the unit it contains.
var _items := {}

func is_occupied(cell: Vector2) -> bool:
	return _items.has(cell)
	
# add a new item but only if the cell is free. Otherwise return false if occupied
func add_item(cell: Vector2, item: Node2D) -> bool:
	var old_item = get_item(cell)
	if old_item == null:
		_items[cell] = item
		return true
	return false
	
func get_item(cell: Vector2):
	if is_occupied(cell):
		return _items[cell]
	return null
	
# return an Array of Items in a rectangle area of cells
func get_items_rect(start_cell: Vector2, end_cell: Vector2) -> Array:
	var items_array = []
	var sign_x = sign(end_cell.x - start_cell.x)
	var sign_y = sign(end_cell.y - start_cell.y)
	if sign_x != 0 and sign_y != 0:
		for x in range(start_cell.x, end_cell.x, sign_x):
			for y in range(start_cell.y, end_cell.y, sign_y):
				var cell = Vector2(x , y)
				var item = get_item(cell)
				if item != null:
					items_array.push_back(item)
	return items_array
	
func get_first_cell():
	if keys().size() >= 1:
		return keys()[0]
	return Vector2.INF
	
func get_last_cell():
	if keys().size() >= 1:
		return keys()[size()-1]
	return Vector2.INF
	
# in case a move to the same cell is requested do nothing and return success
# if the logic is depend on this it has to be tested before calling
func move_item(from_cell: Vector2, to_cell: Vector2) -> bool:
	if from_cell == to_cell:
		return true
		
	var from_item = get_item(from_cell)
	var to_item = get_item(to_cell)
	if from_item != null and to_item == null:
		add_item(to_cell, from_item)
		_items.erase(from_cell)
		return true
	return false
	
# remove cell object from Dictionary and queue_free() it
func erease_item(cell: Vector2) -> bool:
	var item = get_item(cell)
	if item != null:
		item.queue_free()
		_items.erase(cell)
		return true
	return false
	
# remove only the object from Dictionary, but DON'T queue_free() it.
# The caller is responsible to later free it or do what ever is needed,
# but the cell is empty on the board
func remove_item(cell: Vector2) -> bool:
	return _items.erase(cell)
	
func size() -> int:
	return _items.size()

func clear() -> void:
	for item in _items.values():
		item.queue_free()
	_items.clear()
	
func duplicate() -> CellManager:
	var dup_cell_manager = CellManager.new()
	dup_cell_manager._items = _items.duplicate()
	return dup_cell_manager
	
func values() -> Array:
	return _items.values()
	
func keys() -> Array:
	return _items.keys()

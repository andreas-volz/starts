extends TileMapLayer

var _cell = Vector2i.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var global_mouse_position := get_global_mouse_position()
		var new_cell = calculate_world_to_map(global_mouse_position)
		
		if _cell != new_cell:
			_cell = new_cell
			Events.cell_hovered.emit(new_cell)
			

	if event is InputEventMouseButton:
		if event.is_pressed():
			var global_mouse_position := get_global_mouse_position()
			_cell = calculate_world_to_map(global_mouse_position)
			
			if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
				Events.cell_clicked_right.emit(_cell)
				
			if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
				Events.cell_clicked.emit(_cell)

# input: position in global coordinate space
# output: coordinate of a texture TileMap grid position
#
# use: take a sceen coordinate (e.e.g with get_global_mouse_position() and find the unit in the CellManager)
func calculate_world_to_map(grid_position: Vector2) -> Vector2i:
	return local_to_map(to_local(grid_position))

# input: coordinate of a texture TileMap grid position
# output: position in global coordinate space
#
# use: put Nodes with global_position() on the screen
func calculate_map_to_world(map_position: Vector2i) -> Vector2:
	return to_global(map_to_local(map_position))

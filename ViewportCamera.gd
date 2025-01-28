extends Camera2D


func _on_scroller_scroll_viewport(direction: Vector2) -> void:
	position += direction

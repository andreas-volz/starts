extends Line2D

@export var circle_color: Color = Color.WHITE

func _draw() -> void:
	# draw some red points on the navigation path to debug the path while development
	for point in points:
		draw_circle(point, 0.5, circle_color, false, 1.0, true)

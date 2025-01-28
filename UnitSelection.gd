class_name UnitSelection
extends Node2D

var circle_size: int = 0 : set=set_circle_size
var vertical_pos: int = 0 : set=set_vertical_pos

func _ready() -> void:
	scale.y = 0.6
	#position.y = 10

func _draw() -> void:
	draw_arc(Vector2(0,0), circle_size, 0, 2*PI, 32, Color.GREEN, 1.0, true)
	
func set_circle_size(value: int):
	circle_size = value
	queue_redraw()

func set_vertical_pos(value: int):
	vertical_pos = value
	queue_redraw()

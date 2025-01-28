extends Node2D

signal select_rect(start_pos: Vector2, end_pos: Vector2)

const RECT_WIDTH := 0.5
const RECT_COLOR = Color.GREEN

var mouse_pressed := false
var box_start := Vector2.ZERO
var box_end := Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				#print("pressed")
				mouse_pressed = true
				box_start = get_local_mouse_position()
			elif event.is_released():
				#print("released")
				mouse_pressed = false
				
				select_rect.emit(box_start, box_end)
				
				queue_redraw()

func _process(delta: float) -> void:
	if mouse_pressed:
		box_end = get_local_mouse_position()
		queue_redraw()
		
func _draw() -> void:
	if mouse_pressed:
		var rect := Rect2(box_start, box_end - box_start)
		draw_rect(rect, RECT_COLOR, false, RECT_WIDTH, true)
	

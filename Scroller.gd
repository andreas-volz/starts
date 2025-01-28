extends Node2D

const SCROLL_FACTOR = 100 # don't change this, change scroll_speed!

signal scroll_viewport(direction: Vector2)

@export var scroll_speed: int = 10
@export var scroll_border: int = 30

var direction := Vector2.ZERO
var activate_scrolling := false

@onready var scroll_timer: Timer = $ScrollTimer

func _process(delta: float) -> void:
	if activate_scrolling:
		if direction != Vector2.ZERO:
			var mouse_position = get_viewport().get_mouse_position()
			var window_size = get_viewport().get_visible_rect().size
			var window_rect := Rect2(Vector2(0, 0), window_size)
			
			# disable the scrolling mechanism as the mouse is moved out of the window
			if not window_rect.has_point(mouse_position):
				activate_scrolling = false
			
			if window_rect.has_point(mouse_position):
				scroll_viewport.emit(direction * delta * SCROLL_FACTOR)
			else:
				direction = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var window_size = get_viewport().get_visible_rect().size
		var window_rect := Rect2(Vector2(0, 0), window_size)
		var scroll_rect = window_rect.grow(-scroll_border)
				
		var mouse_position = event.position
		if not scroll_rect.has_point(mouse_position):
			direction = Vector2.ZERO
			if mouse_position.x > scroll_rect.size.x:
				direction.x = scroll_speed
			elif mouse_position.x < window_size.x - scroll_rect.size.x:
				direction.x = -scroll_speed
				
			if mouse_position.y > scroll_rect.size.y:
				direction.y = scroll_speed
			elif mouse_position.y < window_size.y - scroll_rect.size.y:
				direction.y = -scroll_speed
				
			scroll_timer.start()
			#activate_scrolling = false
		else:
			direction = Vector2.ZERO
			activate_scrolling = false
						
func get_scale_factor() -> float:
	var scale_factor: float = min(
		(float(get_viewport().size.x) / get_viewport().get_visible_rect().size.x),
		(float(get_viewport().size.y) / get_viewport().get_visible_rect().size.y)
	)
	return scale_factor
	
func _on_scroll_timer_timeout() -> void:
	activate_scrolling = true

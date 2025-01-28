extends Node2D

var resource_manager: ResourceManager = ResourceManager.new()

var star_unit: StarUnit

@onready var start: Marker2D = $Start

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.GRAY)
	
	#set_window_size(Vector2(1152, 648))
	#set_window_size(Vector2(640, 480))
	
	star_unit = StarUnit.new(resource_manager)
	star_unit.load_id(3)
	star_unit.set_team_color(0)
	start.add_child(star_unit)

	star_unit._star_flingy._star_main_sprite._star_main_image.iscript_proc.move.connect(_on_iscript_move)

	star_unit.set_direction(PathFinderGrid.Directions.EAST)
	star_unit.play(IScript.AnimationType.Walking)

func set_window_size(window_size: Vector2):
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	DisplayServer.window_set_size(window_size)

func _on_iscript_move(relative: Vector2):
	var new_position := star_unit.global_position + relative
	
	var window_size = get_viewport().get_visible_rect().size
	var window_rect := Rect2(Vector2(0, 0), window_size)
	var window_middle := window_rect.grow(-50)
	
	if not window_middle.has_point(new_position):
		var new_direction := randi_range(0, 7)
		star_unit.set_direction(new_direction)
		
	star_unit.global_position = new_position

	
	

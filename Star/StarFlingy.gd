class_name StarFlingy
extends StarObject

var _dat: DatFlingy : get=get_dat
var _star_main_sprite: StarSprite

var _last_frame_direction := 0
var _movement_control: DatFlingy.movement_control_enum_t

var max_directions: int

var flingy_time: float = 1.0 / 120.0 # update flingy frames with 120fps => with 24fps had jitter effects!
var delta_flingy_t: float = 0.0

func _process(delta: float) -> void:
	delta_flingy_t += delta
		
	if delta_flingy_t >= flingy_time:
		process_flingy_control_frame()
		delta_flingy_t = 0
		
func process_flingy_control_frame():
	#print("process_flingy_control_frame")
	for child_sprite: StarSprite in get_children():
		child_sprite.process_flingy_control_frame()
		
func get_dat() -> DatFlingy:
	return _dat

func load_id(flingy_id):
	var dat_flingy := DatFlingy.new(_resource_manager, flingy_id)
	load_dat(dat_flingy)

func load_dat(dat_flingy: DatFlingy):
	_dat = dat_flingy
	
	for child in get_children():
		child.queue_free()
		
	# IScript control has only 8 direction movement, otherwise it's 32
	if dat_flingy.movement_control() == DatFlingy.movement_control_enum_t.MOVEMENT_CONTROL_ENUM_ISCRIPT:
		max_directions = 8
	else:
		max_directions = 32
	#else:
		#if dat_flingy.sprite_obj().image_obj().gfx_turns():
			#max_directions = 32
		#else:
			#max_directions = 16
	
	_star_main_sprite = add_sprite_id(dat_flingy.sprite())
	
func add_sprite_id(sprite_id: int) -> StarSprite:
	var star_sprite = StarSprite.new(_resource_manager)
	star_sprite.load_id(sprite_id)
	add_child(star_sprite)
	return star_sprite
	
func add_sprite_dat(dat_sprite: DatSprite) -> StarSprite:
	var star_sprite = StarSprite.new(_resource_manager)
	star_sprite.load_dat(dat_sprite)
	add_child(star_sprite)
	return star_sprite


#func set_direction(d: int) -> int:
	#direction = wrapi(d, 0, max_directions)
	#return direction
	

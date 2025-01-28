class_name StarSprite
extends StarObject

var _dat: DatSprite : get=get_dat
var _star_main_image: StarImage

func process_flingy_control_frame():
	for child_image: StarImage in get_children():
		child_image.process_flingy_control_frame()
		#if child_image.iscript_proc.first_playfram == true:
			#child_image.visible = true
		
func get_dat() -> DatSprite:
	return _dat

func load_id(sprite_id):
	var dat_sprite := DatSprite.new(_resource_manager, sprite_id)
	load_dat(dat_sprite)

func load_dat(dat_sprite: DatSprite):
	_dat = dat_sprite
	
	for child: StarImage in get_children():
		child.queue_free()
	
	_star_main_image = add_image_id(dat_sprite.image())

func add_image_id(image_id: int) -> StarImage:
	var dat_image := DatImage.new(_resource_manager, image_id)
	return add_image_dat(dat_image)
	
func add_image_dat(dat_image: DatImage) -> StarImage:
	var star_image = StarImage.new(_resource_manager)
	star_image.load_dat(dat_image)
	star_image.iscript_proc.imgul.connect(_on_imgul)
	star_image.iscript_proc.imgol.connect(_on_imgol)
	star_image.set_parent_image(_star_main_image)
	add_child(star_image)
	#star_image.visible = false
	return star_image

func _on_imgul(image_id: int, pos: Vector2i):
	var star_image := add_image_id(image_id)
	star_image.z_index = _star_main_image.z_index - 1 # TODO: as workaround just add the image one below the main image
	star_image.position = pos
	
func _on_imgol(image_id: int, pos: Vector2i):
	var star_image := add_image_id(image_id)
	star_image.z_index = _star_main_image.z_index + 1 # TODO: as workaround just add the image one above the main image
	star_image.position = pos

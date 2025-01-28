class_name StarImage
extends Sprite2D # TODO: resign to be StarImage a StarObject?

const COLOR_PALETTE_SWAP = preload("res://shaders/color_palette_swap.gdshader")
const COLOR_SWAP_RANGE := Vector2i(8, 16) # swap the range 8-16 colors from the palette

var _resource_manager: ResourceManager
var _dat: DatImage : get=get_dat

var graphic_resource: GraphicResource
var _loaded_image_grp: int = -1
var _star_parent_image: StarImage

var iscript_proc: IScriptProc
var _gfx_turns: bool

var direction: int

var loaded_texture: PortableCompressedTexture2D

func _init(resource_manager: ResourceManager = null):
	_resource_manager = resource_manager
	
	# TODO: high z index as test
	z_index = 100
		
	material = ShaderMaterial.new()
	material.shader = COLOR_PALETTE_SWAP

	var packed_colors: PackedColorArray
	for i in range(COLOR_SWAP_RANGE[0], COLOR_SWAP_RANGE[1]): 
		var original_color := resource_manager.tunit_palette_resource.get_rgb_array(i)
		packed_colors.push_back(RGBMapResource.get_color8_array(original_color))
			
	material.set_shader_parameter("original_colors", packed_colors)
	material.set_shader_parameter("used_colors", get_swap_range_num())
	
func get_swap_range_num() -> int:
	return COLOR_SWAP_RANGE[1] - COLOR_SWAP_RANGE[0]
	
func process_flingy_control_frame():
	var frame_direction = direction
	var half: int = 4 # this is the size of half directions when to flip the images
	if _gfx_turns:
		if frame_direction > half:
			frame_direction = half - (frame_direction - half)
			flip_h = true
		else:
			flip_h = false
		
	var playfram = iscript_proc.playfram
		
	#if iscript_proc.followmaingraphic == true:
	if _star_parent_image:
		playfram = _star_parent_image.iscript_proc.playfram
		
	# TODO: play the transition images in between the 8 directions
	
	#if iscript_proc.first_playfram:
	#texture = loaded_texture # if I update it here it looks better, but process_flingy_control_frame() works only in flingy objects :-(
	frame = playfram + frame_direction * half
	#visible = true
				
	#_last_frame_direction = frame_direction 
		
func get_dat() -> DatImage:
	return _dat
	


func set_team_color(color_index: int):
	if material == null:
		return
		
	if _resource_manager.tunit_rgbmap_resource.colors.size() % get_swap_range_num() != 0:
		return
		
	if _resource_manager.tunit_rgbmap_resource.colors.size() < color_index * get_swap_range_num():
		return
		
	var packed_colors: PackedColorArray
	for i in get_swap_range_num():
		packed_colors.push_back(RGBMapResource.get_color8_array(_resource_manager.tunit_rgbmap_resource.get_rgb_array(color_index * get_swap_range_num() + i)))
	material.set_shader_parameter("replace_colors", packed_colors)

func load_id(image_id):
	var dat_image := DatImage.new(_resource_manager, image_id)
	load_dat(dat_image)

func load_dat(dat_image: DatImage):
	_dat = dat_image

	# in case the same image is yet loaded just leave
	if _loaded_image_grp == dat_image.grp():
		return

	_gfx_turns = dat_image.gfx_turns()
	
	var grp_name: String = dat_image.grp_tbl().name1()
	grp_name = grp_name.replace("\\", "/")
	grp_name = grp_name.trim_suffix(".grp")
	grp_name = grp_name.to_lower() # the filenames are converted lowercase, but in tbl resource not, so lower it
	
	if dat_image.draw_function() == DatImage.draw_function_enum_t.DRAW_FUNCTION_ENUM_REMAPPING:
		if dat_image.remapping() == DatImage.remapping_enum_t.REMAPPING_ENUM_OFIRE:
			grp_name += "_ofire"
		elif dat_image.remapping() == DatImage.remapping_enum_t.REMAPPING_ENUM_GFIRE:
			grp_name += "_gfire"
		elif dat_image.remapping() == DatImage.remapping_enum_t.REMAPPING_ENUM_BFIRE:
			grp_name += "_bfire"
		elif dat_image.remapping() == DatImage.remapping_enum_t.REMAPPING_ENUM_BEXPL:
			grp_name += "_bexpl"
		else:
			grp_name += "_ofire"
	elif dat_image.draw_function() == DatImage.draw_function_enum_t.DRAW_FUNCTION_ENUM_SHADOW:
		# TODO: fake a black shadow until correct implementation for ground and flying units
		material = null
		modulate = Color(0, 0, 0, 255)
		
	var graphic_path = _resource_manager.starts_resources_path + "graphics/unit/" + grp_name + ".tres"
	graphic_resource = ResourceLoader.load(graphic_path)

	var png_path = graphic_path.get_basename() + ".png"
	var portable_texture: PortableCompressedTexture2D = PortableCompressedTexture2D.new()
	var portable_image: Image = Image.new()
	portable_image = portable_image.load_from_file(png_path)
	portable_texture.create_from_image(portable_image, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)
	print("loadImage PNG: ", png_path)
	
	loaded_texture = portable_texture
	
	texture = loaded_texture
		
	var frame_width = graphic_resource.width
	var horizontal_frames : int = loaded_texture.get_width() / graphic_resource.width
	var vertical_frames: int = loaded_texture.get_height() / graphic_resource.height
	
	hframes = horizontal_frames
	vframes = vertical_frames
	#print("hframes: ", hframes)
	#print("vframes: ", vframes)
	
	

	iscript_proc = IScriptProc.new(_resource_manager, dat_image.iscript())
	# it is important to set the Init before adding it to the scene. 
	# Otherwise it would start running the process loop with unclear opcode_index
	iscript_proc.play(IScript.AnimationType.Init)
	
	add_child(iscript_proc)

	_loaded_image_grp = dat_image.grp()

func play(animation_type: IScript.AnimationType):
	iscript_proc.play(animation_type)

func set_parent_image(star_parent_image: StarImage):
	_star_parent_image = star_parent_image

	

class_name CmdBtns
extends UISprite

const COLOR_PALETTE_SWAP = preload("res://shaders/color_palette_swap.gdshader")
const COLOR_SWAP_RANGE := Vector2i(0, 16) # swap the range 8-16 colors from the palette

var graphic_resource: GraphicResource

var _resource_manager: ResourceManager

func _init_colors(resource_manager: ResourceManager) -> void:
	material = ShaderMaterial.new()
	material.shader = COLOR_PALETTE_SWAP
	
	var packed_colors: PackedColorArray
	for i in get_swap_range_num():
		var original_color := resource_manager.unique_palette_rgbmap_resource.get_rgb_array(i)
		packed_colors.push_back(RGBMapResource.get_color8_array(original_color))
			
	material.set_shader_parameter("original_colors", packed_colors)
	material.set_shader_parameter("used_colors", get_swap_range_num())


func _init_resources(resource_manager: ResourceManager) -> void:
	_resource_manager = resource_manager
	_init_colors(resource_manager)

	var graphic_path = resource_manager.starts_resources_path + "graphics/unit/cmdbtns/cmdbtns"
	graphic_resource = ResourceLoader.load(graphic_path + ".tres")

	var png_path = graphic_path + ".png"
	var portable_texture: PortableCompressedTexture2D = PortableCompressedTexture2D.new()
	var portable_image: Image = Image.new()
	portable_image = portable_image.load_from_file(png_path)
	portable_texture.create_from_image(portable_image, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

	hframes = portable_texture.get_size().x / graphic_resource.width
	vframes = portable_texture.get_size().y / graphic_resource.height
	
	texture = portable_texture

func get_swap_range_num() -> int:
	return COLOR_SWAP_RANGE[1] - COLOR_SWAP_RANGE[0]

func set_color(color_index: int):
	var packed_colors: PackedColorArray
	for i in get_swap_range_num():
		packed_colors.push_back(RGBMapResource.get_color8_array(_resource_manager.ticon_rgbmap_resource.get_rgb_array(color_index * get_swap_range_num() + i)))
	material.set_shader_parameter("replace_colors", packed_colors)

	

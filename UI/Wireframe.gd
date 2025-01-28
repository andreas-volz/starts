class_name Wireframe
extends UISprite

# TODO:
# configure shields+wireframe true/false
# configure heatmap true/false

const COLOR_PALETTE_SWAP = preload("res://shaders/color_palette_swap.gdshader")
const MAX_COLOR := 8

const POSITIONS_INNER_SHIELDS: Array[int] = [192]
const COLORS_INNER_SHIELDS: Array[int] = [3, 4, 5, 6, 7, 8, 9, 2]

const POSITIONS_OUTER_SHIELDS: Array[int] = [193]
const COLORS_OUTER_SHIELDS: Array[int] = [4, 5, 6, 7, 8, 9, 2, 2]

const POSITIONS_WIREFRAME_SECTIONS: Array[int] = [208, 209, 210, 211]
const COLORS_WIREFRAME_SECTIONS: Array[int] = [1, 0, 10]

const POSITIONS_BRIGHT_INNER_HEATMAP: Array[int] = [216]
const COLORS_BRIGHT_INNER_HEATMAP: Array[int] = [0, 1, 1, 19, 19, 14]

const POSITIONS_DARK_INNER_HEATMAP: Array[int] = [217]
const COLORS_DARK_INNER_HEATMAP: Array[int] = [1, 18, 18, 11, 11, 6]

const POSITIONS_BRIGHT_OUTER_HEATMAP: Array[int] = [218]
const COLORS_BRIGHT_OUTER_HEATMAP: Array[int] = [18, 20, 20, 10, 13, 7]

const POSITIONS_DARK_OUTER_HEATMAP: Array[int] = [219]
const COLORS_DARK_OUTER_HEATMAP: Array[int] = [10, 12, 16, 16, 6, 8]

@export_exp_easing var  wireframe_weights0 := 0.221
@export_exp_easing var  wireframe_weights1 := 0.542
@export_exp_easing var  wireframe_weights2 := 2.12
@export_exp_easing var  wireframe_weights3 := 2.92

var graphic_resource: GraphicResource
var _resource_manager: ResourceManager
var wireframe_weights_array: Array[float]

enum ColorType {
	WIREFRAME,
	HEATMAP
}

enum WireframeType {
	GROUP,
	TRANSPORT,
	STANDARD
}

var colortype: ColorType = ColorType.WIREFRAME : set=set_colortype

func _init() -> void:
	shuffle_wireframes()
		
func shuffle_wireframes():
	# create array from above easing curves per wireframe color area
	wireframe_weights_array = [wireframe_weights0, wireframe_weights1, wireframe_weights2, wireframe_weights3]
	
	# shuffle the weights after initialization to visualize some random color display
	wireframe_weights_array.shuffle()

func set_colortype(colortype_param: ColorType) -> void:
	colortype = colortype_param
	material = ShaderMaterial.new()
	material.shader = COLOR_PALETTE_SWAP
	
	var packed_colors: PackedColorArray
	
	# order in those arrays need to align with the shader replace Color array order below in set_health()!
	var positions_array: Array = []
	positions_array.push_back(POSITIONS_INNER_SHIELDS)
	positions_array.push_back(POSITIONS_OUTER_SHIELDS)
	if colortype == ColorType.WIREFRAME:
		positions_array.push_back(POSITIONS_WIREFRAME_SECTIONS)
	elif colortype == ColorType.HEATMAP:
		positions_array.push_back(POSITIONS_BRIGHT_INNER_HEATMAP)
		positions_array.push_back(POSITIONS_DARK_INNER_HEATMAP)
		positions_array.push_back(POSITIONS_BRIGHT_OUTER_HEATMAP)
		positions_array.push_back(POSITIONS_DARK_OUTER_HEATMAP)
		
	for palette_positions in positions_array:
		for i in palette_positions:
			var original_color := _resource_manager.unique_palette_rgbmap_resource.get_rgb_array(i)
			packed_colors.push_back(RGBMapResource.get_color8_array(original_color))
			
	if not packed_colors.is_empty():
		material.set_shader_parameter("original_colors", packed_colors)
		material.set_shader_parameter("used_colors", MAX_COLOR)

func _init_resources(resource_manager: ResourceManager) -> void:
	_resource_manager = resource_manager

func load_texture(wireframe_type: WireframeType):
	assert(_resource_manager)
	
	# This is aligned to the generated png files.
	var wireframe_type_str: String
	if wireframe_type == WireframeType.GROUP:
		wireframe_type_str = "grpwire"
	elif wireframe_type == WireframeType.TRANSPORT:
		wireframe_type_str = "tranwire"
	elif wireframe_type == WireframeType.STANDARD:
		wireframe_type_str = "wirefram"
	
	var graphic_path = _resource_manager.starts_resources_path + "graphics/unit/wirefram/" + wireframe_type_str
	graphic_resource = ResourceLoader.load(graphic_path + ".tres")

	var png_path = graphic_path + ".png"
	var portable_texture: PortableCompressedTexture2D = PortableCompressedTexture2D.new()
	var portable_image: Image = Image.new()
	portable_image = portable_image.load_from_file(png_path)
	portable_texture.create_from_image(portable_image, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)

	hframes = portable_texture.get_size().x / graphic_resource.width
	vframes = portable_texture.get_size().y / graphic_resource.height
	
	texture = portable_texture

## health_percent (wireframe): 0.0 -> nearly death (red) / 1.0 -> full health (green)
## health_percent (heatmap): 0.0 -> nearly death (blue) / 1.0 -> full health (red) 
## shields_percent: 0.0 -> no shields / 1.0 -> full shields
func set_health(health_percent: float, shields_percent: float):
	var packed_colors: PackedColorArray 
	var replace_color: Array[int]
	
	health_percent = clampf(health_percent, 0.0, 1.0)
	shields_percent = clampf(shields_percent, 0.0, 1.0)
			
	## shields (index once calculated as all have the same size)
	var shields_index: int = clamp(COLORS_INNER_SHIELDS.size() - remap(shields_percent, 0.0, 1.0, 0, COLORS_INNER_SHIELDS.size()), 0, COLORS_INNER_SHIELDS.size()-1)
		
	for positions_size in POSITIONS_INNER_SHIELDS.size():
		replace_color = _resource_manager.twire_rgbmap_resource.get_rgb_array(COLORS_INNER_SHIELDS[shields_index])
		packed_colors.push_back(RGBMapResource.get_color8_array(replace_color))
		
	for positions_size in POSITIONS_OUTER_SHIELDS.size():
		replace_color = _resource_manager.twire_rgbmap_resource.get_rgb_array(COLORS_OUTER_SHIELDS[shields_index])
		packed_colors.push_back(RGBMapResource.get_color8_array(replace_color))
	
	### wireframe
	if colortype == ColorType.WIREFRAME:
		var wireframe_index_array: Array[int]
		for i in range(4):
			var eased_value := mini(floori(ease(1-health_percent, wireframe_weights_array[i]) * 3), 2)
			wireframe_index_array.push_back(eased_value)
			
		for index in wireframe_index_array:
			replace_color = _resource_manager.twire_rgbmap_resource.get_rgb_array(COLORS_WIREFRAME_SECTIONS[index])
			packed_colors.push_back(RGBMapResource.get_color8_array(replace_color))
	
	## heatmap (index once calculated as all have the same size)
	elif colortype == ColorType.HEATMAP:
		var heatmap_index: int = clamp(COLORS_BRIGHT_INNER_HEATMAP.size() - remap(health_percent, 0.0, 1.0, 0, COLORS_BRIGHT_INNER_HEATMAP.size()), 0, COLORS_BRIGHT_INNER_HEATMAP.size()-1)
		
		for positions_size in POSITIONS_BRIGHT_INNER_HEATMAP.size():
			replace_color = _resource_manager.twire_rgbmap_resource.get_rgb_array(COLORS_BRIGHT_INNER_HEATMAP[heatmap_index])
			packed_colors.push_back(RGBMapResource.get_color8_array(replace_color))
			
		for positions_size in POSITIONS_DARK_INNER_HEATMAP.size():
			replace_color = _resource_manager.twire_rgbmap_resource.get_rgb_array(COLORS_DARK_INNER_HEATMAP[heatmap_index])
			packed_colors.push_back(RGBMapResource.get_color8_array(replace_color))
			
		for positions_size in POSITIONS_BRIGHT_OUTER_HEATMAP.size():
			replace_color = _resource_manager.twire_rgbmap_resource.get_rgb_array(COLORS_BRIGHT_OUTER_HEATMAP[heatmap_index])
			packed_colors.push_back(RGBMapResource.get_color8_array(replace_color))
			
		for positions_size in POSITIONS_DARK_OUTER_HEATMAP.size():
			replace_color = _resource_manager.twire_rgbmap_resource.get_rgb_array(COLORS_DARK_OUTER_HEATMAP[heatmap_index])
			packed_colors.push_back(RGBMapResource.get_color8_array(replace_color))
		
	if not packed_colors.is_empty():
		material.set_shader_parameter("replace_colors", packed_colors)

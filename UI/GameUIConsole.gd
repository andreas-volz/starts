extends NinePatchRect

var _resource_manager: ResourceManager

@onready var portrait_overlay: TextureRect = %PortraitOverlay
	
func init_resources(resource_manager: ResourceManager):
	_resource_manager = resource_manager
	
func set_race(race: String):
	load_console(race)
	load_portrait_overlay(race)

func load_console(race: String):
	var png_path = _resource_manager.starts_resources_path + "/gameui/" + race + "_console.png"
	var portable_texture: PortableCompressedTexture2D = PortableCompressedTexture2D.new()
	var portable_image: Image = Image.new()
	portable_image = portable_image.load_from_file(png_path)
	portable_texture.create_from_image(portable_image, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)
	texture = portable_texture

func load_portrait_overlay(race: String):
	var png_path = _resource_manager.starts_resources_path + "/gameui/" + race + "_console_overlay.png"
	var portable_texture: PortableCompressedTexture2D = PortableCompressedTexture2D.new()
	var portable_image: Image = Image.new()
	portable_image = portable_image.load_from_file(png_path)
	portable_texture.create_from_image(portable_image, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)
	portrait_overlay.texture = portable_texture

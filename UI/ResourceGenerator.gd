extends Control

var starts_converter_path: String = "/home/andreas/Games/starts/converter/" # TODO: make this selectable by configuration option or maybe zip loader
var starts_resources_path: String = "user://resources/"
var dat_path = starts_converter_path + "dat/"
var dat_resource_path = starts_resources_path + "/dat/"
var resource_extension := ".tres"

@onready var background: TextureRect = %Background
@onready var done: Label = $CenterContainer/VBoxContainer/DONE
@onready var converter_path: LineEdit = $CenterContainer/VBoxContainer/ConverterPath

func _ready() -> void:
	var png_path = starts_converter_path + "gameui/mainmenu_backgnd.png"
	var portable_texture: PortableCompressedTexture2D = PortableCompressedTexture2D.new()
	var portable_image: Image = Image.new()
	portable_image = portable_image.load_from_file(png_path)
	portable_texture.create_from_image(portable_image, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)
	background.texture = portable_texture
	converter_path.text = starts_converter_path


func generate_resources():
	# generation order matters!
	generate_tbl()
	generate_units_dat()
	generate_flingy_dat()
	generate_sprites_dat()
	generate_images_dat()
	generate_sfxdata_dat()
	generate_portdata_dat()
	generate_weapons_dat()
	generate_upgrades_dat()
	generate_orders_dat()
	generate_techdata_dat()
	
	generate_buttons()
	
	generate_iscript()
	generate_graphics()
	
	generate_tileset_cv5()
	generate_tileset_vf4()
	generate_tileset_vr4()
	generate_chk()
	# just copy the Tiled resources for YATI over
	copy_resources("campaign", "tmj")
	copy_resources("tileset/tiled", "tsj")
	copy_resources("tileset/tiled", "png")
	# vx4 resources aren't needed as long as I use YATI Tiled loader
	
	generate_cursor()
	generate_rgbmap()
	
	generate_palettes()
	
	copy_resources("sounds", "ogg")
	
	copy_resources("portraits", "ogv")
	
	copy_resources("gameui", "png")
	
	###################


func generate_tbl():
	var dat_folder = starts_converter_path + "/dat/tbl/"
	var resource_folder = starts_resources_path + "/dat/tbl/"
	
	var resource_factory := TblResourceFactory.new()
	
	var basedir = dat_folder.get_base_dir()
	var filename = dat_folder.get_file()
	var dir = DirAccess.open(dat_folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "json":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
		
func generate_graphics():
	var dat_folder = starts_converter_path + "graphics"
	var resource_folder = starts_resources_path # no graphic suffix needed
	
	var resource_factory := GraphicResourceFactory.new()
	
	var basedir = dat_folder.get_base_dir()
	var filename = dat_folder.get_file()
	var files := Utils.get_all_files(dat_folder, "json")
	for file:String in files:
		var rel_file = file.trim_prefix(starts_converter_path)
		resource_factory.create_resource(starts_converter_path, rel_file, resource_folder)
	
func generate_images():
	var dat_folder = starts_converter_path + "/dat/images/"
	var resource_folder = starts_resources_path + "/dat/images/"
	
	var resource_factory := ImageResourceFactory.new()
	
	var basedir = dat_folder.get_base_dir()
	var filename = dat_folder.get_file()
	var dir = DirAccess.open(dat_folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "json":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
	
func generate_sprites():
	var dat_folder = starts_converter_path + "/dat/sprites/"
	var resource_folder = starts_resources_path + "/dat/sprites/"
	
	var resource_factory := SpriteResourceFactory.new()
	
	var basedir = dat_folder.get_base_dir()
	var filename = dat_folder.get_file()
	var dir = DirAccess.open(dat_folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "json":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
	
func generate_units_dat():
	var dat_name := "units_dat"
	var resource_factory := UnitResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)
				
func generate_flingy_dat():
	var dat_name := "flingy_dat"
	var resource_factory := FlingyResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)
				
func generate_sprites_dat():
	var dat_name := "sprites_dat"
	var resource_factory := SpriteResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)
	
func generate_images_dat():
	var dat_name := "images_dat"
	var resource_factory := ImageResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)
	
func generate_sfxdata_dat():
	var dat_name := "sfxdata_dat"
	var resource_factory := SfxResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)
	
func generate_portdata_dat():
	var dat_name := "portdata_dat"
	var resource_factory := PortraitResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)

func generate_weapons_dat():
	var dat_name := "weapons_dat"
	var resource_factory := WeaponResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)
	
func generate_upgrades_dat():
	var dat_name := "upgrades_dat"
	var resource_factory := UpgradeResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)

func generate_orders_dat():
	var dat_name := "orders_dat"
	var resource_factory := OrderResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)

func generate_techdata_dat():
	var dat_name := "techdata_dat"
	var resource_factory := TechResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)

func generate_buttons():
	var dat_name := "buttons_conv"
	var resource_factory := ButtonResourceFactory.new()
	resource_factory.create_resource(dat_path + dat_name + ".json" , dat_resource_path + dat_name + resource_extension)

func generate_tileset_cv5():
	var dat_folder = starts_converter_path + "/tileset/cv5/"
	var resource_folder = starts_resources_path + "/tileset/cv5/"
	
	var resource_factory := TilesetCV5ResourceFactory.new()
	
	var basedir = dat_folder.get_base_dir()
	var filename = dat_folder.get_file()
	var dir = DirAccess.open(dat_folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "json":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
				
func generate_tileset_vf4():
	var dat_folder = starts_converter_path + "/tileset/vf4/"
	var resource_folder = starts_resources_path + "/tileset/vf4/"
	
	var resource_factory := TilesetVF4ResourceFactory.new()
	
	var basedir = dat_folder.get_base_dir()
	var filename = dat_folder.get_file()
	var dir = DirAccess.open(dat_folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "json":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
				
func generate_tileset_vr4():
	var dat_folder = starts_converter_path + "/tileset/vr4/"
	var resource_folder = starts_resources_path + "/tileset/vr4/"
	
	var resource_factory := TilesetVR4ResourceFactory.new()
	
	var basedir = dat_folder.get_base_dir()
	var filename = dat_folder.get_file()
	var dir = DirAccess.open(dat_folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "json":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
				
func generate_chk():
	var folder = starts_converter_path + "/campaign/"
	var resource_folder = starts_resources_path + "/campaign/"
	
	var resource_factory := ChkResourceFactory.new()
	
	var basedir = folder.get_base_dir()
	var filename = folder.get_file()
	var dir = DirAccess.open(folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "json":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
				
func generate_rgbmap():
	var folder = starts_converter_path + "/rgbmap/"
	var resource_folder = starts_resources_path + "/rgbmap/"
	
	var resource_factory := RGBMapResourceFactory.new()
	
	var basedir = folder.get_base_dir()
	var filename = folder.get_file()
	var dir = DirAccess.open(folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "json":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
				
func generate_palettes():
	var folder = starts_converter_path + "/palette/"
	var resource_folder = starts_resources_path + "/palette/"
	
	var resource_factory := PaletteResourceFactory.new()
	
	var basedir = folder.get_base_dir()
	var filename = folder.get_file()
	var dir = DirAccess.open(folder)
	if dir:
		var files = dir.get_files()
		for file in files:
			if file.get_extension() == "pal":
				var full_file = basedir + "/" + file
				resource_factory.create_resource(full_file, resource_folder)
				
func generate_cursor():
	var folder = starts_converter_path + "/cursor/"
	var resource_folder = starts_resources_path + "/cursor/"
	
	var resource_factory := CursorResourceFactory.new()
	
	var basedir = folder.get_base_dir()
	var filename = folder.get_file()
	var files := Utils.get_all_files(folder, "json")
	for file: String in files:
		#var rel_file = file.trim_prefix(starts_converter_path)
		resource_factory.create_resource(file, resource_folder)
	
func generate_iscript():
	var input_file = starts_converter_path + "/iscript/iscript.txt"
	var output_file = starts_resources_path + "/iscript/iscript.tres"
	
	var resource_factory := IScriptResourceFactory.new()
	
	resource_factory.create_resource(input_file, output_file)
	
func copy_resources(foldername: String, type: String = ""):
	var folder = starts_converter_path + foldername
	var resource_folder = starts_resources_path + foldername
	
	var files := Utils.get_all_files(folder, type)
	for file: String in files:
		var rel_file = file.trim_prefix(starts_converter_path)
		var target: String = starts_resources_path + "/" + rel_file
		DirAccess.make_dir_recursive_absolute(target.get_base_dir())
		var error := DirAccess.copy_absolute(file, target)
		if error != OK:
			printerr("failed copy: " + file + " => " + target)


func _on_generate_button_pressed() -> void:
	starts_converter_path = converter_path.text
	
	# TODO: run in thread and give feedback
	generate_resources()
	done.visible = true

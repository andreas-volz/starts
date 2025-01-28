class_name DatViewer
extends Control

const LINK_IMAGE = preload("res://Assets/ui/NavigationLink2D.svg")
const GAME_PATH = "res://Game.tscn"

const MAX_UNITS: int = 227

const ISCRIPT_ANIMATIONTYPE_MAPPING: Array[String] = [
  "Init",
  "Death",
  "GndAttkInit",
  "AirAttkInit",
  "Unused1",
  "GndAttkRpt",
  "AirAttkRpt",
  "CastSpell",
  "GndAttkToIdle",
  "AirAttkToIdle",
  "Unused2",
  "Walking",
  "WalkingToIdle",
  "SpecialState1",
  "SpecialState2",
  "AlmostBuilt",
  "Built",
  "Landing",
  "LiftOff",
  "IsWorking",
  "WorkingToIdle",
  "WarpIn",
  "Unused3",
  "StarEditInit",
  "Disable",
  "Burrow",
  "UnBurrow",
  "Enable"
]

const OPCODE_COMMAND_MAPPING: Array[String] = [
  "playfram",
  "playframtile",
  "sethorpos",
  "setvertpos",
  "setpos",
  "wait",
  "waitrand",
  "goto",
  "imgol",
  "imgul",
  "imgolorig",
  "switchul",
  "unknown_0c",
  "imgoluselo",
  "imguluselo",
  "sprol",
  "highsprol",
  "lowsprul",
  "uflunstable",
  "spruluselo",
  "sprul",
  "sproluselo",
  "end",
  "setflipstate",
  "playsnd",
  "playsndrand",
  "playsndbtwn",
  "domissiledmg",
  "attackmelee",
  "followmaingraphic",
  "randcondjmp",
  "turnccwise",
  "turncwise",
  "turn1cwise",
  "turnrand",
  "setspawnframe",
  "sigorder",
  "attackwith",
  "attack",
  "castspell",
  "useweapon",
  "move",
  "gotorepeatattk",
  "engframe",
  "engset",
  "unknown_2d",
  "nobrkcodestart",
  "nobrkcodeend",
  "ignorerest",
  "attkshiftproj",
  "tmprmgraphicstart",
  "tmprmgraphicend",
  "setfldirect",
  "call",
  "return",
  "setflspeed",
  "creategasoverlays",
  "pwrupcondjmp",
  "trgtrangecondjmp",
  "trgtarccondjmp",
  "curdirectcondjmp",
  "imgulnextid",
  "unknown_3e",
  "liftoffcondjmp",
  "warpoverlay",
  "orderdone",
  "grdsprol",
  "unknown_43",
  "dogrddamage"
]

enum ListMode {
	UNIT,
	FLINGY,
	SPRITE,
	IMAGE,
	WEAPON,
	SOUND,
	PORTRAIT,
	UPGRADE,
	ORDER,
	TECH,
	MAP,
	BUTTON
}

const ListModeNames : Array[String] = [
	"Units",
	"Flingy",
	"Sprites",
	"Images",
	"Weapons",
	"Sounds",
	"Portraits",
	"Upgrades",
	"Orders",
	"Technology",
	"Maps",
	"Buttons"
]

var resource_manager: ResourceManager = ResourceManager.new()
var star_object = null
var direction := 0
var active_list_mode: ListMode
var team_color: int
var list_index_memory: Array[int] = []
var view_scale := 2.0

@onready var unit_pivot: Control = %UnitPivot
@onready var dat_list: Tree = %DatList
@onready var rotate_timer: Timer = $RotateTimer
@onready var category_selector: OptionButton = %CategorySelector
@onready var property_tree: Tree = %PropertyTree
@onready var animation_list: Tree = %AnimationList
@onready var opcode_list = %OpcodeList
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var video_stream_player: VideoStreamPlayer = %VideoStreamPlayer
@onready var background: TextureRect = %Background
@onready var cmd_btns: CmdBtns = %CmdBtns
@onready var wireframe1: Wireframe = %Wireframe1
@onready var wireframe2: Wireframe = %Wireframe2
@onready var wireframe3: Wireframe = %Wireframe3
@onready var wireframe_spin: SpinBox = %WireframeSpin
@onready var shilds_spin: SpinBox = %ShildsSpin
@onready var wireframe_container: CenterContainer = %WireframeContainer
@onready var cmd_btns_container: CenterContainer = %CmdBtnsContainer
@onready var rotate_button: CheckButton = %RotateButton
@onready var team_container: HBoxContainer = %TeamContainer
@onready var play_button: Button = %PlayButton
@onready var main_stage: CenterContainer = %MainStage
@onready var animation_list_container: HBoxContainer = %AnimationListContainer
@onready var cmd_btns_grid: CommandBtnsGrid = %CmdBtnsGrid



func _ready() -> void:
	set_window_size(Vector2(1152, 648))
	load_background_image()
	
	wireframe1._init_resources(resource_manager)
	wireframe2._init_resources(resource_manager)
	wireframe3._init_resources(resource_manager)
	
	wireframe1.load_texture(Wireframe.WireframeType.GROUP)
	wireframe2.load_texture(Wireframe.WireframeType.TRANSPORT)
	wireframe3.load_texture(Wireframe.WireframeType.STANDARD)
	
	load_unit(0)
	
	_init_category_selector()
	_init_list_memory()
	
	dat_list.fill_units_list(resource_manager)
	select_tree_item(dat_list, 0)
	active_list_mode = ListMode.UNIT
	
	fill_opcode_list()
	
	cmd_btns_grid._init_resources(resource_manager)
	
	cmd_btns._init_resources(resource_manager)
	cmd_btns.set_color(0)
	
func load_background_image():
	var png_path = resource_manager.starts_resources_path + "gameui/mainmenu_backgnd.png"
	var portable_texture: PortableCompressedTexture2D = PortableCompressedTexture2D.new()
	var portable_image: Image = Image.new()
	portable_image = portable_image.load_from_file(png_path)
	portable_texture.create_from_image(portable_image, PortableCompressedTexture2D.COMPRESSION_MODE_LOSSLESS)
	background.texture = portable_texture
	
## initialize the list memory to select 0 at start
func _init_list_memory():
	list_index_memory.resize(ListModeNames.size())
	list_index_memory.fill(0)
	
func _init_category_selector():
	var i: int = 0
	for name in ListModeNames:
		category_selector.add_item(name, i)
		i += 1
		
func set_window_size(window_size: Vector2):
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	DisplayServer.window_set_size(window_size)
	
func unload_star_object():
	if star_object:
		star_object.queue_free()
		star_object = null

func load_unit(unit_id: int):
	var star_unit := StarUnit.new(resource_manager)
	star_unit.load_id(unit_id)
	star_unit.set_team_color(1)
	unit_pivot.add_child(star_unit)
	star_unit.set_team_color(team_color)
	star_unit.scale = Vector2(view_scale, view_scale)
	star_object = star_unit
	#star_object.play(IScript.AnimationType.Init)
	
func load_flingy(flingy_id: int):
	var star_flingy := StarFlingy.new(resource_manager)
	star_flingy.load_id(flingy_id)
	unit_pivot.add_child(star_flingy)
	star_flingy.set_team_color(team_color)
	star_flingy.scale = Vector2(view_scale, view_scale)
	star_object = star_flingy
	
func load_sprite(sprite_id: int):
	var star_sprite := StarSprite.new(resource_manager)
	star_sprite.load_id(sprite_id)
	unit_pivot.add_child(star_sprite)
	star_sprite.set_team_color(team_color)
	star_sprite.scale = Vector2(view_scale, view_scale)
	star_object = star_sprite
	
func load_image(image_id: int):
	var star_image := StarImage.new(resource_manager)
	star_image.load_id(image_id)
	unit_pivot.add_child(star_image)
	star_image.set_team_color(team_color)
	star_image.scale = Vector2(view_scale, view_scale)
	star_object = star_image
	
func fill_opcode_list():
	opcode_list.clear()
	var popcode_list_root: TreeItem = opcode_list.create_item()
	
	for opcode: IScript.Opcode in resource_manager.iscript.opcode_list:
		var opcode_str := OPCODE_COMMAND_MAPPING[opcode.code]
		var tree_item: TreeItem 
		tree_item = opcode_list.create_item(popcode_list_root)
		tree_item.set_text(0, opcode_str)
		var arg_str: String
		for arg in opcode.args:
			arg_str = arg_str + " " + str(arg)
			
		tree_item.set_text(1, arg_str)

func fill_animation_list(dat_image: DatImage):
	animation_list.clear()
	# print all possible animations (those which have other jump as 0)
	var iscript = dat_image.iscript()
	if dat_image._resource_manager.iscript.animation_header_dict.has(iscript):
		var animation_header: Array = dat_image._resource_manager.iscript.animation_header_dict[iscript]
		var i: int = 0
		#print("possible animations:")
		var animation_tree_root: TreeItem = animation_list.create_item()
		for animation_start in animation_header:
			if animation_start != 0:
				var possible_animation := ISCRIPT_ANIMATIONTYPE_MAPPING[i]
				var tree_item = animation_list.create_item(animation_tree_root)
				tree_item.set_text(0, possible_animation)
				tree_item.set_metadata(0, i)
			i += 1
			
func fill_portrait_list(dat_portrait: DatPortrait):
	animation_list.clear()
	var animation_tree_root: TreeItem = animation_list.create_item()
	
	var idle_base_path := dat_portrait.video_idle_tbl().name1()
	idle_base_path = idle_base_path.replace("\\", "/")
	idle_base_path = idle_base_path.to_lower() # the filenames are converted lowercase, but in tbl resource not, so lower it
		
	var talking_base_path := dat_portrait.video_talking_tbl().name1()
	talking_base_path = talking_base_path.replace("\\", "/")
	talking_base_path = talking_base_path.to_lower() # the filenames are converted lowercase, but in tbl resource not, so lower it
	
	var idle_i: int = 0
	while true:
		var idle_video_name := idle_base_path + str(idle_i) + ".ogv"
		var idle_full_path := resource_manager.starts_resources_path + "portraits/" + idle_video_name
		if FileAccess.file_exists(idle_full_path):
			var tree_item = animation_list.create_item(animation_tree_root)
			tree_item.set_text(0, idle_video_name)
		else:
			break
		idle_i += 1
		
	var talking_i: int = 0
	while true:
		var talking_video_name := talking_base_path + str(talking_i) + ".ogv"
		var talking_full_path := resource_manager.starts_resources_path + "portraits/" + talking_video_name
		if FileAccess.file_exists(talking_full_path):
			var tree_item = animation_list.create_item(animation_tree_root)
			tree_item.set_text(0, talking_video_name)
		else:
			break
		talking_i += 1
	
func _on_dat_list_item_selected() -> void:
	var item: TreeItem = dat_list.get_selected()
	var metadata = item.get_metadata(0)
	assert(metadata != null, "no index in metadata(0)")
	var item_id: int = metadata
	list_index_memory[active_list_mode] = item_id
	
	if active_list_mode == ListMode.UNIT:
		units_list_item_selected(item_id)
	elif active_list_mode == ListMode.FLINGY:
		flingy_list_item_selected(item_id)
	elif active_list_mode == ListMode.SPRITE:
		sprites_list_item_selected(item_id)
	elif active_list_mode == ListMode.IMAGE:
		images_list_item_selected(item_id)
	elif active_list_mode == ListMode.WEAPON:
		weapons_list_item_selected(item_id)
	elif active_list_mode == ListMode.SOUND:
		sounds_list_item_selected(item_id)
	elif active_list_mode == ListMode.PORTRAIT:
		portraits_list_item_selected(item_id)
	elif active_list_mode == ListMode.UPGRADE:
		upgrades_list_item_selected(item_id)
	elif active_list_mode == ListMode.ORDER:
		orders_list_item_selected(item_id)
	elif active_list_mode == ListMode.TECH:
		tech_list_item_selected(item_id)
	elif active_list_mode == ListMode.MAP:
		map_list_item_selected(item_id)
	elif active_list_mode == ListMode.BUTTON:
		button_list_item_selected(item_id)
	
func units_list_item_selected(item_id: int):
	unload_star_object()
	load_unit(item_id)
	property_tree.fill_units_property_tree(star_object.get_dat())
	var dat_image: DatImage = star_object._star_flingy._star_main_sprite._star_main_image.get_dat()
	fill_animation_list(dat_image)
	opcode_list.visible = true
	# the first 228 items in cmdctns.grp are nunbered like the units
	cmd_btns_container.visible = true
	cmd_btns.frame = item_id
	
	wireframe_container.visible = true
	rotate_button.visible = true
	team_container.visible = true
	play_button.visible = true
	main_stage.use_top_left = false
	animation_list_container.visible = true
	cmd_btns_grid.visible = false
	
	wireframe1.visible = true
	wireframe2.visible = true
	wireframe3.visible = true
	wireframe1.frame = item_id
	wireframe2.frame = item_id
	wireframe3.frame = item_id
	
	# reinitilaize wireframe shuffler each time a unit is selected to test the function
	# in a real game use case this would't look real!
	wireframe1.shuffle_wireframes()
	wireframe2.shuffle_wireframes()
	wireframe3.shuffle_wireframes()
	
	var dat_unit: DatUnit = star_object.get_dat()
	if dat_unit.group_flags().zerg:
		wireframe1.set_colortype(Wireframe.ColorType.HEATMAP)
		wireframe2.set_colortype(Wireframe.ColorType.HEATMAP)
		wireframe3.set_colortype(Wireframe.ColorType.HEATMAP)
	else:
		wireframe1.set_colortype(Wireframe.ColorType.WIREFRAME)
		wireframe2.set_colortype(Wireframe.ColorType.WIREFRAME)
		wireframe3.set_colortype(Wireframe.ColorType.WIREFRAME)
		
	wireframe1.set_health(wireframe_spin.value, shilds_spin.value)
	wireframe2.set_health(wireframe_spin.value, shilds_spin.value)
	wireframe3.set_health(wireframe_spin.value, shilds_spin.value)
	
func flingy_list_item_selected(item_id: int):
	unload_star_object()
	load_flingy(item_id)
	property_tree.fill_flingy_property_tree(star_object.get_dat())
	var dat_image: DatImage = star_object._star_main_sprite._star_main_image.get_dat()
	fill_animation_list(dat_image)
	opcode_list.visible = true
	cmd_btns_container.visible = false
	wireframe_container.visible = false
	rotate_button.visible = true
	team_container.visible = true
	play_button.visible = true
	main_stage.use_top_left = false
	animation_list_container.visible = true
	cmd_btns_grid.visible = false
	
func sprites_list_item_selected(item_id: int):
	unload_star_object()
	load_sprite(item_id)
	property_tree.fill_sprites_property_tree(star_object.get_dat())
	var dat_image: DatImage = star_object._star_main_image.get_dat()
	fill_animation_list(dat_image)
	opcode_list.visible = true
	cmd_btns_container.visible = false
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = true
	play_button.visible = false
	main_stage.use_top_left = false
	animation_list_container.visible = true
	cmd_btns_grid.visible = false

func images_list_item_selected(item_id: int):
	unload_star_object()
	load_image(item_id)
	property_tree.fill_images_property_tree(star_object.get_dat())
	var dat_image: DatImage = star_object.get_dat()
	fill_animation_list(dat_image)
	opcode_list.visible = true
	cmd_btns_container.visible = false
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = true
	play_button.visible = false
	main_stage.use_top_left = false
	animation_list_container.visible = true
	cmd_btns_grid.visible = false
	
func weapons_list_item_selected(item_id: int):
	unload_star_object()
	var dat_weapon := DatWeapon.new(resource_manager, item_id)
	load_flingy(dat_weapon.flingy())
	property_tree.fill_weapons_property_tree(dat_weapon)
	var dat_image: DatImage = star_object._star_main_sprite._star_main_image.get_dat()
	fill_animation_list(dat_image)
	opcode_list.visible = true
	cmd_btns_container.visible = true
	cmd_btns.frame = dat_weapon.icon()
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = false
	play_button.visible = true
	main_stage.use_top_left = false
	animation_list_container.visible = true
	cmd_btns_grid.visible = false
		
func sounds_list_item_selected(item_id: int):
	unload_star_object()
	var dat_sfx := DatSfx.new(resource_manager, item_id)
	property_tree.fill_sounds_property_tree(dat_sfx)
	animation_list.clear()
	opcode_list.visible = false
	cmd_btns_container.visible = false
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = false
	play_button.visible = true
	main_stage.use_top_left = false
	animation_list_container.visible = false
	cmd_btns_grid.visible = false
	
func portraits_list_item_selected(item_id: int):
	unload_star_object()
	var dat_portrait := DatPortrait.new(resource_manager, item_id)
	property_tree.fill_portraits_property_tree(dat_portrait)
	fill_portrait_list(dat_portrait)
	select_tree_item(animation_list, 0)
	opcode_list.visible = false
	cmd_btns_container.visible = false
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = false
	play_button.visible = true
	main_stage.use_top_left = false
	animation_list_container.visible = true
	cmd_btns_grid.visible = false
	
func upgrades_list_item_selected(item_id: int):
	unload_star_object()
	var dat_upgrade := DatUpgrade.new(resource_manager, item_id)
	property_tree.fill_upgrades_property_tree(dat_upgrade)
	animation_list.clear()
	opcode_list.visible = false
	cmd_btns_container.visible = true
	cmd_btns.frame = dat_upgrade.icon()
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = false
	play_button.visible = false
	main_stage.use_top_left = false
	animation_list_container.visible = false
	cmd_btns_grid.visible = false
		
func orders_list_item_selected(item_id: int):
	unload_star_object()
	var dat_order := DatOrder.new(resource_manager, item_id)
	property_tree.fill_orders_property_tree(dat_order)
	animation_list.clear()
	opcode_list.visible = false
	
	if dat_order.highlight() != DatOrder.HIGHLIGHT_NONE:
		cmd_btns_container.visible = true
		cmd_btns.frame = dat_order.highlight()
	else:
		cmd_btns_container.visible = false
		
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = false
	play_button.visible = false
	main_stage.use_top_left = false
	animation_list_container.visible = false
	cmd_btns_grid.visible = false
	
func tech_list_item_selected(item_id: int):
	unload_star_object()
	var dat_tech := DatTech.new(resource_manager, item_id)
	property_tree.fill_tech_property_tree(dat_tech)
	animation_list.clear()
	opcode_list.visible = false
	if dat_tech.icon() != DatOrder.HIGHLIGHT_NONE:
		cmd_btns_container.visible = true
		cmd_btns.frame = dat_tech.icon()
	else:
		cmd_btns_container.visible = false
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = false
	play_button.visible = false
	main_stage.use_top_left = false
	animation_list_container.visible = false
	cmd_btns_grid.visible = false
	
func map_list_item_selected(item_id: int):
	unload_star_object()
	property_tree.fill_map_property_tree()
	animation_list.clear()
	opcode_list.visible = false
	cmd_btns_container.visible = false
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = false
	play_button.visible = true
	animation_list_container.visible = false
	cmd_btns_grid.visible = false
	
	var map_name: String
	var tree_item: TreeItem = dat_list.get_selected()
	if tree_item:
		map_name = tree_item.get_text(0)
		
	var tmj_file = resource_manager.starts_resources_path + "campaign/" + map_name + ".tmj"
	
	var importer_module = preload("res://YATI/runtime/Importer.gd").new()
	var added_node = importer_module.import(tmj_file)
	var map_size = added_node.get_used_rect().size

	star_object = added_node.duplicate()
	star_object.scale = Vector2(0.2, 0.2)

	unit_pivot.add_child(star_object)
	main_stage.use_top_left = true
	
func button_list_item_selected(item_id: int):
	unload_star_object()
	property_tree.fill_button_property_tree()
	animation_list.clear()
	opcode_list.visible = false
	cmd_btns_container.visible = false
	wireframe_container.visible = false
	rotate_button.visible = false
	team_container.visible = false
	play_button.visible = false
	animation_list_container.visible = false
	
	var tree_index: int
	var tree_item: TreeItem = dat_list.get_selected()
	if tree_item:
		tree_index = tree_item.get_metadata(0)
	
	cmd_btns_grid.clear()
	cmd_btns_grid.visible = true
	
	var button_sets = resource_manager.buttons_resource.list[tree_index]
	for button in button_sets:
		var button_position = button.position - 1
		var cmdbtn: CmdBtns = cmd_btns_grid.get_child(button_position)
		cmdbtn.set_color(0)
		
		var dat_unit = DatUnit.new(resource_manager, button.actvar)
		
		# TODO: this isn't correct for all cases
		var actstr: String
		var reqstr: String
		if button.actstr > 0:
			var cmdbtn_act_tbl = DatTbl.new(resource_manager.stat_txt_tbl_resource, button.actstr-1)
			actstr = cmdbtn_act_tbl.name1()
		if button.reqstr > 0:
			var cmdbtn_req_tbl = DatTbl.new(resource_manager.stat_txt_tbl_resource, button.reqstr-1)
			reqstr = cmdbtn_req_tbl.name1()
			
		if not actstr.is_empty():
			cmdbtn.tooltip_text = "Provide: " + actstr
		if not reqstr.is_empty():
			if not actstr.is_empty():
				cmdbtn.tooltip_text += '\n'
			cmdbtn.tooltip_text += "Request: " + reqstr
		
		if button.actcat == ButtonResource.Category.UNIT:
			cmdbtn.frame = dat_unit.get_id()
		elif button.actcat == ButtonResource.Category.UNIT_EXT:
			cmdbtn.frame = dat_unit.get_id()
		elif button.actcat == ButtonResource.Category.TECH:
			var dat_tech = DatTech.new(resource_manager, button.actvar)
			cmdbtn.frame = dat_tech.icon()
		elif button.actcat == ButtonResource.Category.UPGRADE:
			var dat_upgrade = DatUpgrade.new(resource_manager, button.actvar)
			cmdbtn.frame = dat_upgrade.icon()
		else:
			# TODO: those have also to be mapped to order dat IDs or what ever
			# marked as grey until matched above
			cmdbtn.frame = button.icon
			#cmdbtn.set_color(2) # TODO: set other color for debug
			
			pass
	
func select_tree_item(tree: Tree, index: int, column: int = 0) -> TreeItem:
	var tree_item: TreeItem = tree.get_root()
	if tree_item:
		var first_item: TreeItem = tree_item.get_child(index)
		if first_item:
			tree.set_selected(first_item, column)
			tree.scroll_to_item(first_item)
	return tree_item
				
func starobject_play():
	if star_object:
		var tree_item: TreeItem = animation_list.get_selected()
		if tree_item:
			var animation_index = tree_item.get_metadata(0)
			star_object.play(animation_index)
			
func sound_play():
	var item: TreeItem = dat_list.get_selected()
	var item_id: int = item.get_metadata(0)
	var dat_sfx := DatSfx.new(resource_manager, item_id)
	
	var ogg_name: String = dat_sfx.sound_file_tbl().name1()
	ogg_name = ogg_name.replace("\\", "/")
	ogg_name = ogg_name.to_lower() # the filenames are converted lowercase, but in tbl resource not, so lower it
	ogg_name = ogg_name.trim_suffix(".wav")
	ogg_name += ".ogg"
	var sound_file = resource_manager.starts_resources_path + "sounds/" + ogg_name
	
	audio_stream_player.stream = AudioStreamOggVorbis.load_from_file(sound_file)
	audio_stream_player.play()
	
func video_play():
	var item: TreeItem = animation_list.get_selected()
	if item:
		var item_file: String = item.get_text(0)
		var video_file = resource_manager.starts_resources_path + "portraits/" + item_file
		var video_stream_theora = VideoStreamTheora.new()

		video_stream_theora.file = video_file
		video_stream_player.stream = video_stream_theora
		video_stream_player.scale = Vector2(view_scale, view_scale)
		
		video_stream_player.play()
			
func map_play():
	var map_name: String
	var tree_item: TreeItem = dat_list.get_selected()
	if tree_item:
		map_name = tree_item.get_text(0)
	
	
	
	#get_tree().change_scene_to_file(GAME_PATH)

func _on_rotate_timer_timeout() -> void:
	if star_object:
		direction = wrapi(direction + 1, 0, 8) #star_object.get_max_directions()
		if star_object.has_method("set_direction"):
			star_object.direction = direction

func _on_rotate_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		rotate_timer.start()
	else:
		rotate_timer.stop()

func _on_category_selector_item_selected(index: int) -> void:
	var select_index := list_index_memory[index]
	active_list_mode = index
	dat_list.fill_list(resource_manager, index)
	select_tree_item(dat_list, select_index)


func _on_property_tree_button_clicked(item: TreeItem, column: int, id: int, mouse_button_index: int) -> void:
	var list_mode = item.get_metadata(column)
	dat_list.fill_list(resource_manager, list_mode)
	active_list_mode = list_mode
	category_selector.select(list_mode)
	select_tree_item(dat_list, id)
	

func _on_team_color_value_changed(value):
	team_color = value
	if star_object:
		star_object.set_team_color(team_color)


func _on_animation_list_item_selected() -> void:
	if active_list_mode == ListMode.UNIT:
		var item: TreeItem = animation_list.get_selected()
		var item_id: int = item.get_metadata(0)
	elif active_list_mode == ListMode.FLINGY:
		var item: TreeItem = animation_list.get_selected()
		var item_id: int = item.get_metadata(0)
	elif active_list_mode == ListMode.SPRITE:
		var item: TreeItem = animation_list.get_selected()
		var item_id: int = item.get_metadata(0)
	elif active_list_mode == ListMode.IMAGE:
		var item: TreeItem = animation_list.get_selected()
		var item_id: int = item.get_metadata(0)
	elif active_list_mode == ListMode.SOUND:
		var item: TreeItem = animation_list.get_selected()
		var item_id: int = item.get_metadata(0)
	elif active_list_mode == ListMode.PORTRAIT:
		var item: TreeItem = animation_list.get_selected()
	
	#var opcode_index = star_object.play(item_id)
	#print("opcode_index: ", opcode_index)

func _on_play_button_pressed() -> void:
	if active_list_mode == ListMode.UNIT:
		starobject_play()
	elif active_list_mode == ListMode.FLINGY:
		starobject_play()
	elif active_list_mode == ListMode.SPRITE:
		starobject_play()
	elif active_list_mode == ListMode.IMAGE:
		starobject_play()
	elif active_list_mode == ListMode.SOUND:
		sound_play()
	elif active_list_mode == ListMode.PORTRAIT:
		video_play()
	elif active_list_mode == ListMode.MAP:
		map_play()

func _on_cmd_btns_spin_value_changed(value: float) -> void:
	cmd_btns.set_color(value)
	
func _on_wireframe_spin_value_changed(value: float) -> void:
	wireframe1.set_health(wireframe_spin.value, shilds_spin.value)
	wireframe2.set_health(wireframe_spin.value, shilds_spin.value)
	wireframe3.set_health(wireframe_spin.value, shilds_spin.value)

func _on_shilds_spin_value_changed(value: float) -> void:
	wireframe1.set_health(wireframe_spin.value, shilds_spin.value)
	wireframe2.set_health(wireframe_spin.value, shilds_spin.value)
	wireframe3.set_health(wireframe_spin.value, shilds_spin.value)

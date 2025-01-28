class_name ResourceManager
extends RefCounted

var starts_resources_path: String = "user://resources/"
var dat_resource_path = starts_resources_path + "/dat/"
var resource_extension := ".tres"

var iscript := IScript.new()
var stat_txt_tbl_resource: TblResource
var units_dat_resource: UnitResource
var flingy_dat_resource: FlingyResource
var sprites_dat_resource: SpriteResource
var images_dat_resource: ImageResource
var sfxdata_dat_resource: SfxResource
var portdata_dat_resource: PortraitResource
var weapons_dat_resource: WeaponResource
var upgrades_dat_resource: UpgradeResource
var orders_dat_resource: OrderResource
var techdata_dat_resource: TechResource

var buttons_resource: ButtonResource

var images_tbl_resource: TblResource
var sfxdata_tbl_resource: TblResource
var portdata_tbl_resource: TblResource

var tunit_rgbmap_resource: RGBMapResource
var ticon_rgbmap_resource: RGBMapResource
var twire_rgbmap_resource: RGBMapResource
var unique_palette_rgbmap_resource: RGBMapResource

var tunit_palette_resource: PaletteResource
#var ticon_palette_resource: PaletteResource
#var twire_palette_resource: PaletteResource


func _init() -> void:
	init_units_dat()
	init_flingy_dat()
	init_sprites_dat()
	init_weapons_dat()
	init_upgrades_dat()
	init_orders_dat()
	init_techdata_dat()
	
	init_buttons()
	
	init_stat_txt_tbl()
	
	init_sfxdata_dat()
	init_sfxdata_tbl()
	
	init_portdata_dat()
	init_portdata_tbl()
	
	init_palette()
	init_rgbmap()
	
	init_images_dat()
	init_images_tbl()
	
	init_iscript_resource()
	
func init_palette():
	# resource to team color the unit
	var tunit_palette_path = starts_resources_path + "palette/tunit.pal.tres"
	tunit_palette_resource = ResourceLoader.load(tunit_palette_path)
	
	#var ticon_palette_path = starts_resources_path + "palette/ticon.pal.tres"
	#ticon_palette_resource = ResourceLoader.load(ticon_palette_path)
	
	#var twire_palette_path = starts_resources_path + "palette/twire.pal.tres"
	#twire_palette_resource = ResourceLoader.load(twire_palette_path)
	
func init_rgbmap():
	# resource to team color the unit
	var tunit_rgbmap_path = starts_resources_path + "rgbmap/tunit.tres"
	tunit_rgbmap_resource = ResourceLoader.load(tunit_rgbmap_path)
	
	var ticon_rgbmap_path = starts_resources_path + "rgbmap/ticon.tres"
	ticon_rgbmap_resource = ResourceLoader.load(ticon_rgbmap_path)
	
	var twire_rgbmap_path = starts_resources_path + "rgbmap/twire.tres"
	twire_rgbmap_resource = ResourceLoader.load(twire_rgbmap_path)
	
	var unique_palette_rgbmap_path = starts_resources_path + "rgbmap/unique_palette.tres"
	unique_palette_rgbmap_resource = ResourceLoader.load(unique_palette_rgbmap_path)
	
	
	
func init_units_dat() -> void:
	var units_dat_path = dat_resource_path + "units_dat.tres"
	units_dat_resource = ResourceLoader.load(units_dat_path)
	
func init_flingy_dat() -> void:
	var flingy_dat_path = dat_resource_path + "flingy_dat.tres"
	flingy_dat_resource = ResourceLoader.load(flingy_dat_path)
	
func init_sprites_dat() -> void:
	var sprites_dat_path = dat_resource_path + "sprites_dat.tres"
	sprites_dat_resource = ResourceLoader.load(sprites_dat_path)
	
func init_images_dat() -> void:
	var images_dat_path = dat_resource_path + "images_dat.tres"
	images_dat_resource = ResourceLoader.load(images_dat_path)
	
func init_images_tbl() -> void:
	var images_tbl_path = dat_resource_path + "tbl/images_tbl.tres"
	images_tbl_resource = ResourceLoader.load(images_tbl_path)
	
func init_sfxdata_dat() -> void:
	var sfxdata_dat_path = dat_resource_path + "sfxdata_dat.tres"
	sfxdata_dat_resource = ResourceLoader.load(sfxdata_dat_path)
		
func init_sfxdata_tbl() -> void:
	var sfxdata_tbl_path = dat_resource_path + "tbl/sfxdata_tbl.tres"
	sfxdata_tbl_resource = ResourceLoader.load(sfxdata_tbl_path)
	
func init_portdata_dat() -> void:
	var portdata_dat_path = dat_resource_path + "portdata_dat.tres"
	portdata_dat_resource = ResourceLoader.load(portdata_dat_path)
	
func init_portdata_tbl() -> void:
	var portdata_tbl_path = dat_resource_path + "tbl/portdata_tbl.tres"
	portdata_tbl_resource = ResourceLoader.load(portdata_tbl_path)
	
func init_weapons_dat() -> void:
	var weapons_dat_path = dat_resource_path + "weapons_dat.tres"
	weapons_dat_resource = ResourceLoader.load(weapons_dat_path)
	
func init_upgrades_dat() -> void:
	var upgrades_dat_path = dat_resource_path + "upgrades_dat.tres"
	upgrades_dat_resource = ResourceLoader.load(upgrades_dat_path)
	
func init_orders_dat() -> void:
	var orders_dat_path = dat_resource_path + "orders_dat.tres"
	orders_dat_resource = ResourceLoader.load(orders_dat_path)
		
func init_techdata_dat() -> void:
	var techdata_dat_path = dat_resource_path + "techdata_dat.tres"
	techdata_dat_resource = ResourceLoader.load(techdata_dat_path)
		
func init_buttons() -> void:
	var buttons_path = dat_resource_path + "buttons_conv.tres"
	buttons_resource = ResourceLoader.load(buttons_path)
		
func init_iscript_resource() -> void:
	var iscript_path = starts_resources_path + "iscript/iscript.tres"
	# local resource variable ensures to free the resource itself after moving the references to the class structure
	var iscript_resource := ResourceLoader.load(iscript_path)

	# copy the animation header references from resource to specific class type
	for anim_header_res in iscript_resource.animation_header_dict:
		var animation_header: Array[IScript.AnimationType] = []
		for anim_res in iscript_resource.animation_header_dict[anim_header_res]:
			animation_header.push_back(anim_res)
		iscript.animation_header_dict[anim_header_res] = animation_header
	
	# copy the opcode references from resource to specific class type
	for opcode_ref in iscript_resource.opcode_list:
		var opcode := IScript.Opcode.new()
		
		if opcode_ref.size() > 0:
			opcode.code = opcode_ref[0]
			if opcode_ref.size() > 1:
				opcode_ref.remove_at(0)
				for a in opcode_ref:
					opcode.args.push_back(a)
		
		iscript.opcode_list.push_back(opcode)

func init_stat_txt_tbl() -> void:
	var tbl_path = starts_resources_path + "dat/tbl/"
	var stat_txt_tbl_path = tbl_path + "stat_txt_tbl.tres"
	stat_txt_tbl_resource = ResourceLoader.load(stat_txt_tbl_path)

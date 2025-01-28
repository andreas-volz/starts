extends TreeFinder

@onready var dat_list = $"."

func clear_change_signal():
	dat_list.clear()
	content_changed.emit()

func fill_list(resource_manager: ResourceManager, list_mode: DatViewer.ListMode):
	if list_mode == DatViewer.ListMode.UNIT:
		dat_list.fill_units_list(resource_manager)
	elif list_mode == DatViewer.ListMode.FLINGY:
		dat_list.fill_flingy_list(resource_manager)
	elif list_mode == DatViewer.ListMode.SPRITE:
		dat_list.fill_sprites_list(resource_manager)
	elif list_mode == DatViewer.ListMode.IMAGE:
		dat_list.fill_images_list(resource_manager)
	elif list_mode == DatViewer.ListMode.WEAPON:
		dat_list.fill_weapons_list(resource_manager)
	elif list_mode == DatViewer.ListMode.SOUND:
		dat_list.fill_sounds_list(resource_manager)
	elif list_mode == DatViewer.ListMode.PORTRAIT:
		dat_list.fill_portraits_list(resource_manager)
	elif list_mode == DatViewer.ListMode.UPGRADE:
		dat_list.fill_upgrades_list(resource_manager)
	elif list_mode == DatViewer.ListMode.ORDER:
		dat_list.fill_orders_list(resource_manager)
	elif list_mode == DatViewer.ListMode.TECH:
		dat_list.fill_tech_list(resource_manager)
	elif list_mode == DatViewer.ListMode.MAP:
		dat_list.fill_map_list(resource_manager)
	elif list_mode == DatViewer.ListMode.BUTTON:
		dat_list.fill_button_list(resource_manager)

func fill_units_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.units_dat_resource.flingy.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_unit = DatUnit.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_unit.name_tbl().name1())
		tree_item.set_metadata(0, i)
	
func fill_flingy_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.flingy_dat_resource.sprite.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_flingy = DatFlingy.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_flingy.sprite_obj().image_obj().grp_tbl().name1())
		tree_item.set_metadata(0, i)
	
func fill_sprites_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.sprites_dat_resource.image.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_sprite= DatSprite.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_sprite.image_obj().grp_tbl().name1())
		tree_item.set_metadata(0, i)
		
func fill_images_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.images_dat_resource.grp.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_image = DatImage.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_image.grp_tbl().name1())
		tree_item.set_metadata(0, i)
		
func fill_weapons_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.weapons_dat_resource.label.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_weapon = DatWeapon.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_weapon.label_tbl().name1())
		tree_item.set_metadata(0, i)

func fill_sounds_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.sfxdata_dat_resource.sound_file.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_sfx = DatSfx.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_sfx.sound_file_tbl().name1())
		tree_item.set_metadata(0, i)
		
func fill_portraits_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.portdata_dat_resource.video_idle.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_portrait = DatPortrait.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_portrait.video_idle_tbl().name1().get_base_dir())
		tree_item.set_metadata(0, i)

func fill_upgrades_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.upgrades_dat_resource.mineral_cost_base.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_upgrade = DatUpgrade.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_upgrade.label_tbl().name1())
		tree_item.set_metadata(0, i)

func fill_orders_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.orders_dat_resource.label.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_order = DatOrder.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_order.label_tbl().name1())
		tree_item.set_metadata(0, i)
		
func fill_tech_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.techdata_dat_resource.label.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		var dat_tech = DatTech.new(resource_manager_param, i)
		tree_item.set_text(0, str(i) + " - " + dat_tech.label_tbl().name1())
		tree_item.set_metadata(0, i)

func fill_map_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	
	var map_folder = resource_manager_param.starts_resources_path + "campaign"
		
	var resource_factory := GraphicResourceFactory.new()
	
	var dat_tree_root: TreeItem = dat_list.create_item()
	var files := Utils.get_all_files(map_folder, "tmj")
	var i := 0
	for file:String in files:
		var tree_item = dat_list.create_item(dat_tree_root)
		var filename = file.get_file().trim_suffix(".tmj")
		tree_item.set_text(0, filename)
		tree_item.set_metadata(0, i)
		
		i += i
		
		#var rel_file = file.trim_prefix(starts_converter_path)
		#resource_factory.create_resource(starts_converter_path, rel_file, resource_folder)

func fill_button_list(resource_manager_param: ResourceManager):
	clear_change_signal()
	var dat_tree_root: TreeItem = dat_list.create_item()
	for i in range(resource_manager_param.buttons_resource.list.size()):
		var tree_item = dat_list.create_item(dat_tree_root)
		
		var unit_text: String
		if i < DatUnit.MAX_UNITS:
			var dat_unit = DatUnit.new(resource_manager_param, i)
			unit_text = dat_unit.name_tbl().name1()
		else:
			unit_text = "<unnamed>"
			
		tree_item.set_text(0, str(i) + " - " + unit_text)
		tree_item.set_metadata(0, i)
	

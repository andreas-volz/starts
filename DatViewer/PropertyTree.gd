extends TreeFinder

@onready var property_tree = $"."

func _ready() -> void:
	property_tree.set_column_title(0, "Property")
	property_tree.set_column_title_alignment(0, HORIZONTAL_ALIGNMENT_LEFT)
	property_tree.set_column_title(1, "Value")
	property_tree.set_column_title_alignment(1, HORIZONTAL_ALIGNMENT_LEFT)

func clear_change_signal():
	property_tree.clear()
	content_changed.emit()

func fill_units_property_tree(dat_unit: DatUnit):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	
	var tree_item: TreeItem 
	var folded_tree_item: TreeItem
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_unit.get_id()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "name")
	tree_item.set_text(1, dat_unit.name_tbl().name1())
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "flingy")
	tree_item.set_text(1, str(dat_unit.flingy()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.flingy())
	tree_item.set_metadata(1, DatViewer.ListMode.FLINGY)
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "subunit1")
	var subunit1 := dat_unit.subunit1()
	tree_item.set_text(1, str(subunit1))
	if subunit1 != DatUnit.SUBUNIT_NONE:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.subunit1())
		tree_item.set_metadata(1, DatViewer.ListMode.UNIT)
	
	# TODO: check the infestation data again if values and logic is correct
	#var infestation := dat_unit.infestation()
	#if infestation != DatUnit.ILLEGAL_INDEX:
		#tree_item = property_tree.create_item(property_tree_root)
		#tree_item.set_text(0, "infestation")
		#tree_item.set_text(1, str(infestation))
		#if infestation != DatUnit.INFESTATION_NONE:
			#tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.infestation())
			#tree_item.set_metadata(1, DatViewer.ListMode.UNIT)
			
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "construction_animation")
	var construction_animation := dat_unit.construction_animation()
	tree_item.set_text(1, str(construction_animation))
	if construction_animation != DatUnit.CONSTRUCTION_NONE:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.construction_animation())
		tree_item.set_metadata(1, DatViewer.ListMode.IMAGE)
		
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "unit_direction")
	tree_item.set_text(1, str(dat_unit.unit_direction()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "shield_enable")
	tree_item.set_text(1, str(dat_unit.shield_enable()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "shield_amount")
	tree_item.set_text(1, str(dat_unit.shield_amount()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "hit_points")
	tree_item.set_text(1, str(dat_unit.hit_points()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "elevation_level")
	tree_item.set_text(1, str(dat_unit.elevation_level()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "rank")
	tree_item.set_text(1, str(dat_unit.rank()))
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "AI Actions")
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "ai_computer_idle")
	tree_item.set_text(1, str(dat_unit.ai_computer_idle()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.ai_computer_idle())
	tree_item.set_metadata(1, DatViewer.ListMode.ORDER)
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "ai_human_idle")
	tree_item.set_text(1, str(dat_unit.ai_human_idle()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.ai_human_idle())
	tree_item.set_metadata(1, DatViewer.ListMode.ORDER)
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "ai_return_to_idle")
	tree_item.set_text(1, str(dat_unit.ai_return_to_idle()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.ai_return_to_idle())
	tree_item.set_metadata(1, DatViewer.ListMode.ORDER)
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "ai_attack_unit")
	tree_item.set_text(1, str(dat_unit.ai_attack_unit()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.ai_attack_unit())
	tree_item.set_metadata(1, DatViewer.ListMode.ORDER)
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "ai_attack_move")
	tree_item.set_text(1, str(dat_unit.ai_attack_move()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.ai_attack_move())
	tree_item.set_metadata(1, DatViewer.ListMode.ORDER)
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "right_click_action")
	tree_item.set_text(1, str(dat_unit.right_click_action()))
	tree_item.set_tooltip_text(1, Utils.enum_to_text(DatUnit.right_click_action_enum_t, dat_unit.right_click_action()))
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "ai_internal")
	tree_item.set_text(1, str(dat_unit.ai_internal()))
		
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "ground_weapon")
	var ground_weapon := dat_unit.ground_weapon()
	tree_item.set_text(1, str(ground_weapon))
	if ground_weapon < dat_unit._resource_manager.weapons_dat_resource.max_weapons():
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.ground_weapon())
		tree_item.set_metadata(1, DatViewer.ListMode.WEAPON)
		
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "air_weapon")
	var air_weapon := dat_unit.air_weapon()
	tree_item.set_text(1, str(air_weapon))
	if air_weapon < dat_unit._resource_manager.weapons_dat_resource.max_weapons():
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.air_weapon())
		tree_item.set_metadata(1, DatViewer.ListMode.WEAPON)
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Special Ability Flags")
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "building")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().building))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "addon")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().addon))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "flyer")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().flyer))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "resourceminer")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().resourceminer))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "subunit")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().subunit))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "flyingbuilding")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().flyingbuilding))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "hero")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().hero))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "regenerate")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().regenerate))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "animatedidle")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().animatedidle))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "cloakable")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().cloakable))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "twounitsinoneegg")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().twounitsinoneegg))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "singleentity")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().singleentity))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "resourcedepot")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().resourcedepot))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "resourcecontainter")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().resourcecontainter))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "robotic")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().robotic))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "detector")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().detector))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "organic")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().organic))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "requirescreep")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().requirescreep))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "unused")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().unused))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "requirespsi")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().requirespsi))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "burrowable")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().burrowable))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "spellcaster")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().spellcaster))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "permanentcloak")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().permanentcloak))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "pickupitem")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().pickupitem))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "ignoresupplycheck")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().ignoresupplycheck))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "usemediumoverlays")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().usemediumoverlays))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "uselargeoverlays")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().uselargeoverlays))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "battlereactions")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().battlereactions))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "fullautoattack")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().fullautoattack))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "invincible")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().invincible))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "mechanical")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().mechanical))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "producesunits")
	tree_item.set_text(1, str(dat_unit.special_ability_flags().producesunits))

	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "unit_size")
	tree_item.set_text(1, str(dat_unit.unit_size()))
	tree_item.set_tooltip_text(1, Utils.enum_to_text(DatUnit.unit_size_enum_t, dat_unit.unit_size()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "armor")
	tree_item.set_text(1, str(dat_unit.armor()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "target_acquisition_range")
	tree_item.set_text(1, str(dat_unit.target_acquisition_range()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "sight_range")
	tree_item.set_text(1, str(dat_unit.sight_range()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "armor_upgrade")
	tree_item.set_text(1, str(dat_unit.armor_upgrade()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.armor_upgrade())
	tree_item.set_metadata(1, DatViewer.ListMode.UPGRADE)
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Sounds")
	var dat_sfx: DatSfx
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "ready_sound")
	tree_item.set_text(1, str(dat_unit.ready_sound()))
	dat_sfx = dat_unit.ready_sound_obj()
	if dat_sfx:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.ready_sound())
		tree_item.set_metadata(1, DatViewer.ListMode.SOUND)
		tree_item.set_tooltip_text(1, str(dat_sfx.sound_file_tbl().name1()))
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "what_sound_start")
	tree_item.set_text(1, str(dat_unit.what_sound_start()))
	dat_sfx = dat_unit.what_sound_start_obj()
	if dat_sfx:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.what_sound_start())
		tree_item.set_metadata(1, DatViewer.ListMode.SOUND)
		tree_item.set_tooltip_text(1, str(dat_sfx.sound_file_tbl().name1()))
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "what_sound_end")
	tree_item.set_text(1, str(dat_unit.what_sound_end()))
	dat_sfx = dat_unit.what_sound_end_obj()
	if dat_sfx:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.what_sound_end())
		tree_item.set_metadata(1, DatViewer.ListMode.SOUND)
		tree_item.set_tooltip_text(1, str(dat_sfx.sound_file_tbl().name1()))
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "piss_sound_start")
	tree_item.set_text(1, str(dat_unit.piss_sound_start()))
	dat_sfx = dat_unit.piss_sound_start_obj()
	if dat_sfx:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.piss_sound_start())
		tree_item.set_metadata(1, DatViewer.ListMode.SOUND)
		tree_item.set_tooltip_text(1, str(dat_sfx.sound_file_tbl().name1()))
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "piss_sound_end")
	tree_item.set_text(1, str(dat_unit.piss_sound_end()))
	dat_sfx = dat_unit.piss_sound_end_obj()
	if dat_sfx:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.piss_sound_end())
		tree_item.set_metadata(1, DatViewer.ListMode.SOUND)
		tree_item.set_tooltip_text(1, str(dat_sfx.sound_file_tbl().name1()))
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "yes_sound_start")
	tree_item.set_text(1, str(dat_unit.yes_sound_start()))
	dat_sfx = dat_unit.yes_sound_start_obj()
	if dat_sfx:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.yes_sound_start())
		tree_item.set_metadata(1, DatViewer.ListMode.SOUND)
		tree_item.set_tooltip_text(1, str(dat_sfx.sound_file_tbl().name1()))
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "yes_sound_end")
	tree_item.set_text(1, str(dat_unit.yes_sound_end()))
	dat_sfx = dat_unit.yes_sound_end_obj()
	if dat_sfx:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.yes_sound_end())
		tree_item.set_metadata(1, DatViewer.ListMode.SOUND)
		tree_item.set_tooltip_text(1, str(dat_sfx.sound_file_tbl().name1()))
			
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "unit_dimension")
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "left")
	tree_item.set_text(1, str(dat_unit.unit_dimension().left))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "up")
	tree_item.set_text(1, str(dat_unit.unit_dimension().up))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "right")
	tree_item.set_text(1, str(dat_unit.unit_dimension().right))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "down")
	tree_item.set_text(1, str(dat_unit.unit_dimension().down))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "portrait")
	tree_item.set_text(1, str(dat_unit.portrait()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_unit.portrait())
	tree_item.set_metadata(1, DatViewer.ListMode.PORTRAIT)
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Group Flags")
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "building")
	tree_item.set_text(1, str(dat_unit.group_flags().building))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "factory")
	tree_item.set_text(1, str(dat_unit.group_flags().factory))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "independent")
	tree_item.set_text(1, str(dat_unit.group_flags().independent))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "men")
	tree_item.set_text(1, str(dat_unit.group_flags().men))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "neutral")
	tree_item.set_text(1, str(dat_unit.group_flags().neutral))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "protoss")
	tree_item.set_text(1, str(dat_unit.group_flags().protoss))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "terran")
	tree_item.set_text(1, str(dat_unit.group_flags().terran))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "zerg")
	tree_item.set_text(1, str(dat_unit.group_flags().zerg))

	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Build Costs")
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "mineral_cost")
	tree_item.set_text(1, str(dat_unit.mineral_cost()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "vespene_cost")
	tree_item.set_text(1, str(dat_unit.vespene_cost()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "build_time")
	tree_item.set_text(1, str(dat_unit.build_time()))
	tree_item.set_tooltip_text(1, str(dat_unit.build_time()/24.0) + " sec")
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Supply")
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "supply_provided")
	tree_item.set_text(1, str(dat_unit.supply_provided()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "supply_required")
	tree_item.set_text(1, str(dat_unit.supply_required()))
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Space")
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "space_provided")
	tree_item.set_text(1, str(dat_unit.space_provided()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "space_required")
	tree_item.set_text(1, str(dat_unit.space_required()))
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Score")
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "build_score")
	tree_item.set_text(1, str(dat_unit.build_score()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "destroy_score")
	tree_item.set_text(1, str(dat_unit.destroy_score()))
	
	
func fill_flingy_property_tree(dat_flingy: DatFlingy):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_flingy.get_id()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "sprite")
	tree_item.set_text(1, str(dat_flingy.sprite()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_flingy.sprite())
	tree_item.set_metadata(1, DatViewer.ListMode.SPRITE)
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "movement_control")
	tree_item.set_text(1, str(dat_flingy.movement_control()))
	tree_item.set_tooltip_text(1, Utils.enum_to_text(DatFlingy.movement_control_enum_t, dat_flingy.movement_control()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "speed")
	tree_item.set_text(1, str(dat_flingy.speed()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "acceleration")
	tree_item.set_text(1, str(dat_flingy.acceleration()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "halt_distance")
	tree_item.set_text(1, str(dat_flingy.halt_distance()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "turn_radius")
	tree_item.set_text(1, str(dat_flingy.turn_radius()))
	
func fill_sprites_property_tree(dat_sprite: DatSprite):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_sprite.get_id()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "image")
	tree_item.set_text(1, str(dat_sprite.image()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_sprite.image())
	tree_item.set_metadata(1, DatViewer.ListMode.IMAGE)
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "health_bar")
	tree_item.set_text(1, str(dat_sprite.health_bar()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "is_visible")
	tree_item.set_text(1, str(dat_sprite.is_visible()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "select_circle_image_size")
	var select_circle_image_size := dat_sprite.select_circle_image_size()
	tree_item.set_text(1, str(select_circle_image_size))
	if select_circle_image_size != DatObject.ILLEGAL_INDEX:
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_sprite.select_circle_image_size())
		tree_item.set_metadata(1, DatViewer.ListMode.IMAGE)
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "select_circle_vertical_pos")
	tree_item.set_text(1, str(dat_sprite.select_circle_vertical_pos()))

func fill_images_property_tree(dat_image: DatImage):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	var folded_tree_item: TreeItem
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_image.get_id()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "grp")
	tree_item.set_text(1, str(dat_image.grp()))
	tree_item.set_tooltip_text(1, dat_image.grp_tbl().name1())
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "gfx_turns")
	tree_item.set_text(1, str(dat_image.gfx_turns()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "clickable")
	tree_item.set_text(1, str(dat_image.clickable()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "use_full_iscript")
	tree_item.set_text(1, str(dat_image.use_full_iscript()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "draw_if_cloaked")
	tree_item.set_text(1, str(dat_image.draw_if_cloaked()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "draw_function")
	tree_item.set_text(1, str(dat_image.draw_function()))
	tree_item.set_tooltip_text(1, Utils.enum_to_text(DatImage.draw_function_enum_t, dat_image.draw_function()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "remapping")
	tree_item.set_text(1, str(dat_image.remapping()))
	tree_item.set_tooltip_text(1, Utils.enum_to_text(DatImage.remapping_enum_t, dat_image.remapping()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "iscript")
	tree_item.set_text(1, str(dat_image.iscript()))

	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Extra overlays placement")

	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "shield_overlay")
	tree_item.set_text(1, str(dat_image.shield_overlay()))
	if dat_image.shield_overlay() != 0:
		tree_item.set_tooltip_text(1, dat_image.shield_overlay_tbl().name1())
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "attack_overlay")
	tree_item.set_text(1, str(dat_image.attack_overlay()))
	if dat_image.attack_overlay() != 0:
		tree_item.set_tooltip_text(1, dat_image.attack_overlay_tbl().name1())
		
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "damage_overlay")
	tree_item.set_text(1, str(dat_image.damage_overlay()))
	if dat_image.damage_overlay() != 0:
		tree_item.set_tooltip_text(1, dat_image.damage_overlay_tbl().name1())
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "special_overlay")
	tree_item.set_text(1, str(dat_image.special_overlay()))
	if dat_image.special_overlay() != 0:
		tree_item.set_tooltip_text(1, dat_image.special_overlay_tbl().name1())
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "landing_dust_overlay")
	tree_item.set_text(1, str(dat_image.landing_dust_overlay()))
	if dat_image.landing_dust_overlay() != 0:
		tree_item.set_tooltip_text(1, dat_image.landing_dust_overlay_tbl().name1())
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "lift_off_dust_overlay")
	tree_item.set_text(1, str(dat_image.lift_off_dust_overlay()))
	if dat_image.lift_off_dust_overlay() != 0:
		tree_item.set_tooltip_text(1, dat_image.lift_off_dust_overlay_tbl().name1())


func fill_weapons_property_tree(dat_weapon: DatWeapon):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	var folded_tree_item: TreeItem
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_weapon.get_id()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "label")
	tree_item.set_text(1, str(dat_weapon.label()))
	tree_item.set_tooltip_text(1, dat_weapon.label_tbl().name1())
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "flingy")
	tree_item.set_text(1, str(dat_weapon.flingy()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_weapon.flingy())
	tree_item.set_metadata(1, DatViewer.ListMode.FLINGY)

	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "explosion")
	tree_item.set_text(1, str(dat_weapon.explosion()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "target_flags")
	tree_item.set_text(1, str(dat_weapon.target_flags())) # TODO: bitfield
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Weapon range")
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "minimum_range")
	tree_item.set_text(1, str(dat_weapon.minimum_range()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "maximum_range")
	tree_item.set_text(1, str(dat_weapon.maximum_range()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "damage_upgrade")
	tree_item.set_text(1, str(dat_weapon.damage_upgrade()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "weapon_type")
	tree_item.set_text(1, str(dat_weapon.weapon_type()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "weapon_behaviour")
	tree_item.set_text(1, str(dat_weapon.weapon_behaviour()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "remove_after")
	tree_item.set_text(1, str(dat_weapon.remove_after()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "explosive_type")
	tree_item.set_text(1, str(dat_weapon.explosive_type()))
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Splash radius")
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "inner_splash_range")
	tree_item.set_text(1, str(dat_weapon.inner_splash_range()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "medium_splash_range")
	tree_item.set_text(1, str(dat_weapon.medium_splash_range()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "outer_splash_range")
	tree_item.set_text(1, str(dat_weapon.outer_splash_range()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "damage_amount")
	tree_item.set_text(1, str(dat_weapon.damage_amount()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "damage_bonus")
	tree_item.set_text(1, str(dat_weapon.damage_bonus()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "weapon_cooldown")
	tree_item.set_text(1, str(dat_weapon.weapon_cooldown()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "damage_factor")
	tree_item.set_text(1, str(dat_weapon.damage_factor()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "attack_angle")
	tree_item.set_text(1, str(dat_weapon.attack_angle()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "launch_spin")
	tree_item.set_text(1, str(dat_weapon.launch_spin()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "x_offset")
	tree_item.set_text(1, str(dat_weapon.x_offset()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "y_offset")
	tree_item.set_text(1, str(dat_weapon.y_offset()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "error_message")
	tree_item.set_text(1, str(dat_weapon.error_message()))
	tree_item.set_tooltip_text(1, dat_weapon.error_message_tbl().name1())
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "icon")
	tree_item.set_text(1, str(dat_weapon.icon()))


func fill_sounds_property_tree(dat_sfx: DatSfx):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_sfx.get_id()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "sound_file")
	tree_item.set_text(1, str(dat_sfx.sound_file()))
	tree_item.set_tooltip_text(1, dat_sfx.sound_file_tbl().name1())

func fill_portraits_property_tree(dat_portrait: DatPortrait):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_portrait.get_id()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "video_idle")
	tree_item.set_text(1, str(dat_portrait.video_idle()))
	tree_item.set_tooltip_text(1, dat_portrait.video_idle_tbl().name1())
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "video_talking")
	tree_item.set_text(1, str(dat_portrait.video_talking()))
	tree_item.set_tooltip_text(1, dat_portrait.video_talking_tbl().name1())
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "change_idle")
	tree_item.set_text(1, str(dat_portrait.change_idle()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "change_talking")
	tree_item.set_text(1, str(dat_portrait.change_talking()))

func fill_upgrades_property_tree(dat_upgrade: DatUpgrade):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	var folded_tree_item: TreeItem
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_upgrade.get_id()))
	
	folded_tree_item = property_tree.create_item(property_tree_root)
	folded_tree_item.set_text(0, "Costs/Factors")
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "mineral_cost_base")
	tree_item.set_text(1, str(dat_upgrade.mineral_cost_base()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "mineral_cost_factor")
	tree_item.set_text(1, str(dat_upgrade.mineral_cost_factor()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "vespene_cost_base")
	tree_item.set_text(1, str(dat_upgrade.vespene_cost_base()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "vespene_cost_factor")
	tree_item.set_text(1, str(dat_upgrade.vespene_cost_factor()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "research_time_base")
	tree_item.set_text(1, str(dat_upgrade.research_time_base()))
	
	tree_item = property_tree.create_item(folded_tree_item)
	tree_item.set_text(0, "research_time_factor")
	tree_item.set_text(1, str(dat_upgrade.research_time_factor()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "icon")
	tree_item.set_text(1, str(dat_upgrade.icon()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "label")
	tree_item.set_text(1, str(dat_upgrade.label()))
	tree_item.set_tooltip_text(1, dat_upgrade.label_tbl().name1())
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "race")
	tree_item.set_text(1, str(dat_upgrade.race()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "max_repeats")
	tree_item.set_text(1, str(dat_upgrade.max_repeats()))
	

func fill_orders_property_tree(dat_order: DatOrder):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_order.get_id()))

	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "label")
	tree_item.set_text(1, str(dat_order.label()))
	tree_item.set_tooltip_text(1, dat_order.label_tbl().name1())
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "use_weapon_targeting")
	tree_item.set_text(1, str(dat_order.use_weapon_targeting()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "interruptible")
	tree_item.set_text(1, str(dat_order.interruptible()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "queueable")
	tree_item.set_text(1, str(dat_order.queueable()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "targeting")
	tree_item.set_text(1, str(dat_order.targeting()))
	if dat_order.targeting() < dat_order._resource_manager.weapons_dat_resource.max_weapons():
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_order.targeting())
		tree_item.set_metadata(1, DatViewer.ListMode.WEAPON)
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "energy")
	tree_item.set_text(1, str(dat_order.energy()))
	if dat_order.energy() < dat_order._resource_manager.techdata_dat_resource.max_energy():
		tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_order.energy())
		tree_item.set_metadata(1, DatViewer.ListMode.TECH)
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "animation")
	tree_item.set_text(1, str(dat_order.animation()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "highlight")
	tree_item.set_text(1, str(dat_order.highlight()))

	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "obscured_order")
	tree_item.set_text(1, str(dat_order.obscured_order()))
	tree_item.add_button(1, DatViewer.LINK_IMAGE, dat_order.obscured_order())
	tree_item.set_metadata(1, DatViewer.ListMode.ORDER)

func fill_tech_property_tree(dat_tech: DatTech):
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "id")
	tree_item.set_text(1, str(dat_tech.get_id()))

	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "label")
	tree_item.set_text(1, str(dat_tech.label()))
	tree_item.set_tooltip_text(1, dat_tech.label_tbl().name1())

	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "mineral_cost")
	tree_item.set_text(1, str(dat_tech.mineral_cost()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "vespene_cost")
	tree_item.set_text(1, str(dat_tech.vespene_cost()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "research_time")
	tree_item.set_text(1, str(dat_tech.research_time()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "energy_required")
	tree_item.set_text(1, str(dat_tech.energy_required()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "icon")
	tree_item.set_text(1, str(dat_tech.icon()))
	
	tree_item = property_tree.create_item(property_tree_root)
	tree_item.set_text(0, "race")
	tree_item.set_text(1, str(dat_tech.race()))
	tree_item.set_tooltip_text(1, Utils.enum_to_text(DatTech.race_enum_t, dat_tech.race()))

func fill_map_property_tree():
	clear_change_signal()

func fill_button_property_tree():
	clear_change_signal()
	var property_tree_root: TreeItem = property_tree.create_item()
	var tree_item: TreeItem 
	
	
	#tree_item = property_tree.create_item(property_tree_root)
	#tree_item.set_text(0, "id")
	#tree_item.set_text(1, str(dat_tech.get_id()))

class_name DatImage
extends DatObject

enum draw_function_enum_t {
	DRAW_FUNCTION_ENUM_NORMAL = 0,
	DRAW_FUNCTION_ENUM_NO_HALLUCINATION = 1,
	DRAW_FUNCTION_ENUM_NON_VISION_CLOAKING = 2,
	DRAW_FUNCTION_ENUM_NON_VISION_CLOAKED = 3,
	DRAW_FUNCTION_ENUM_NON_VISION_UNCLOAKING = 4,
	DRAW_FUNCTION_ENUM_VISION_CLOAKING = 5,
	DRAW_FUNCTION_ENUM_VISION_CLOAKED = 6,
	DRAW_FUNCTION_ENUM_VISION_UNCLOAKING = 7,
	DRAW_FUNCTION_ENUM_EMP_SHOCKWAVE = 8,
	DRAW_FUNCTION_ENUM_REMAPPING = 9,
	DRAW_FUNCTION_ENUM_SHADOW = 10,
	DRAW_FUNCTION_ENUM_HP_BAR = 11,
	DRAW_FUNCTION_ENUM_WARP_TEXTURE = 12,
	DRAW_FUNCTION_ENUM_SEL_CIRCLE_REMAPPING = 13,
	DRAW_FUNCTION_ENUM_PLAYER_COLOR = 14,
	DRAW_FUNCTION_ENUM_UPDATE_RECT = 15,
	DRAW_FUNCTION_ENUM_HALLUCINATION = 16,
	DRAW_FUNCTION_ENUM_WARP_FLASH = 17
}

enum remapping_enum_t {
	REMAPPING_ENUM_NO_REMAPPING = 0,
	REMAPPING_ENUM_OFIRE = 1,
	REMAPPING_ENUM_GFIRE = 2,
	REMAPPING_ENUM_BFIRE = 3,
	REMAPPING_ENUM_BEXPL = 4,
	REMAPPING_ENUM_SPECIAL = 5,
	REMAPPING_ENUM_UNKNOWN1 = 6,
	REMAPPING_ENUM_UNKNOWN2 = 7,
	REMAPPING_ENUM_UNKNOWN3 = 8,
	REMAPPING_ENUM_UNKNOWN4 = 9
}

func grp() -> int:
	return _resource_manager.images_dat_resource.grp[_id]

func grp_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.images_tbl_resource, grp()-1)

func gfx_turns() -> bool:
	return _resource_manager.images_dat_resource.gfx_turns[_id]
	
func clickable() -> bool:
	return _resource_manager.images_dat_resource.clickable[_id]
	
func use_full_iscript() -> bool:
	return _resource_manager.images_dat_resource.use_full_iscript[_id]
	
func draw_if_cloaked() -> bool:
	return _resource_manager.images_dat_resource.draw_if_cloaked[_id]

func draw_function() -> draw_function_enum_t:
	return _resource_manager.images_dat_resource.draw_function[_id]
	
func remapping() -> remapping_enum_t:
	return _resource_manager.images_dat_resource.remapping[_id]

func iscript() -> int:
	return _resource_manager.images_dat_resource.iscript[_id]

func shield_overlay() -> int:
	return _resource_manager.images_dat_resource.shield_overlay[_id]
	
func shield_overlay_tbl() -> DatTbl:
	if shield_overlay() == 0:
		return null
	return DatTbl.new(_resource_manager.images_tbl_resource, shield_overlay()-1)
	
func attack_overlay() -> int:
	return _resource_manager.images_dat_resource.attack_overlay[_id]
	
func attack_overlay_tbl() -> DatTbl:
	if attack_overlay() == 0:
		return null
	return DatTbl.new(_resource_manager.images_tbl_resource, attack_overlay()-1)
	
func damage_overlay() -> int:
	return _resource_manager.images_dat_resource.damage_overlay[_id]
	
func damage_overlay_tbl() -> DatTbl:
	if damage_overlay() == 0:
		return null
	return DatTbl.new(_resource_manager.images_tbl_resource, damage_overlay()-1)
	
func special_overlay() -> int:
	return _resource_manager.images_dat_resource.special_overlay[_id]
	
func special_overlay_tbl() -> DatTbl:
	if special_overlay() == 0:
		return null
	return DatTbl.new(_resource_manager.images_tbl_resource, special_overlay()-1)
	
func landing_dust_overlay() -> int:
	return _resource_manager.images_dat_resource.landing_dust_overlay[_id]
	
func landing_dust_overlay_tbl() -> DatTbl:
	if landing_dust_overlay() == 0:
		return null
	return DatTbl.new(_resource_manager.images_tbl_resource, landing_dust_overlay()-1)
	
func lift_off_dust_overlay() -> int:
	return _resource_manager.images_dat_resource.lift_off_dust_overlay[_id]
	
func lift_off_dust_overlay_tbl() -> DatTbl:
	if lift_off_dust_overlay() == 0:
		return null
	return DatTbl.new(_resource_manager.images_tbl_resource, lift_off_dust_overlay()-1)

class_name DatWeapon
extends DatObject

enum attack_type_enum_t {
	ATTACK_TYPE_ENUM_AIR_ONLY = 1,
	ATTACK_TYPE_ENUM_GROUND_ONLY = 2,
	ATTACK_TYPE_ENUM_GROUND_AND_AIR = 3,
	ATTACK_TYPE_ENUM_UNITS_ONLY = 4,
	ATTACK_TYPE_ENUM_GROUND_UNITS_ONLY = 18
};

enum weapon_type_enum_t {
	WEAPON_TYPE_ENUM_INDEPENDENT = 0,
	WEAPON_TYPE_ENUM_EXPLOSIVE = 1,
	WEAPON_TYPE_ENUM_CONCUSSIVE = 2,
	WEAPON_TYPE_ENUM_NORMAL = 3,
	WEAPON_TYPE_ENUM_IGNORE_AMOR = 4
};
	
func label() -> int:
	return _resource_manager.weapons_dat_resource.label[_id]

func label_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.stat_txt_tbl_resource, label() - 1)

func flingy() -> int:
	return _resource_manager.weapons_dat_resource.flingy[_id]

func flingy_obj() -> DatFlingy:
	return DatFlingy.new(_resource_manager, flingy())

func explosion() -> int:
	return _resource_manager.weapons_dat_resource.explosion[_id]
	
func target_flags() -> attack_type_enum_t: # TODO: verify this
	return _resource_manager.weapons_dat_resource.target_flags[_id]
	
func minimum_range() -> int:
	return _resource_manager.weapons_dat_resource.minimum_range[_id]
	
func maximum_range() -> int:
	return _resource_manager.weapons_dat_resource.maximum_range[_id]
	
func damage_upgrade() -> int:
	return _resource_manager.weapons_dat_resource.damage_upgrade[_id]
	
func weapon_type() -> weapon_type_enum_t: # TODO: verify this
	return _resource_manager.weapons_dat_resource.weapon_type[_id]
	
func weapon_behaviour() -> int:
	return _resource_manager.weapons_dat_resource.weapon_behaviour[_id]
	
func remove_after() -> int:
	return _resource_manager.weapons_dat_resource.remove_after[_id]
	
func explosive_type() -> int:
	return _resource_manager.weapons_dat_resource.explosive_type[_id]
	
func inner_splash_range() -> int:
	return _resource_manager.weapons_dat_resource.inner_splash_range[_id]

func medium_splash_range() -> int:
	return _resource_manager.weapons_dat_resource.medium_splash_range[_id]
	
func outer_splash_range() -> int:
	return _resource_manager.weapons_dat_resource.outer_splash_range[_id]
	
func damage_amount() -> int:
	return _resource_manager.weapons_dat_resource.damage_amount[_id]
	
func damage_bonus() -> int:
	return _resource_manager.weapons_dat_resource.damage_bonus[_id]
	
func weapon_cooldown() -> int:
	return _resource_manager.weapons_dat_resource.weapon_cooldown[_id]
	
func damage_factor() -> int:
	return _resource_manager.weapons_dat_resource.damage_factor[_id]
	
func attack_angle() -> int:
	return _resource_manager.weapons_dat_resource.attack_angle[_id]
	
func launch_spin() -> int:
	return _resource_manager.weapons_dat_resource.launch_spin[_id]
	
func x_offset() -> int:
	return _resource_manager.weapons_dat_resource.x_offset[_id]
	
func y_offset() -> int:
	return _resource_manager.weapons_dat_resource.y_offset[_id]
	
func error_message() -> int:
	return _resource_manager.weapons_dat_resource.error_message[_id]

func error_message_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.stat_txt_tbl_resource, error_message() - 1)
	
func icon() -> int:
	return _resource_manager.weapons_dat_resource.icon[_id]
	

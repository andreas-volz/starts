class_name DatUnit
extends DatObject

const PORTRAIT_NONE: int = 65535
const SOUND_NONE: int = 0
const CONSTRUCTION_NONE: int = 0
const SUBUNIT_NONE: int = 228
const INFESTATION_NONE: int = 228
const BUILDING_START: int = 106
const MAX_UNITS: int = 228

enum unit_size_enum_t {
	UNIT_SIZE_ENUM_INDENDENT = 0,
	UNIT_SIZE_ENUM_SMALL = 1,
	UNIT_SIZE_ENUM_MEDIUM = 2,
	UNIT_SIZE_ENUM_LARGE = 3
};

enum right_click_action_enum_t {
	RIGHT_CLICK_ACTION_ENUM_NO_COMMANDS_AUTO_ATTACK = 0,
	RIGHT_CLICK_ACTION_ENUM_NORMAL_MOVEMENT_NORMAL_ATTACK = 1,
	RIGHT_CLICK_ACTION_ENUM_NORMAL_MOVEMENT_NO_ATTACK = 2,
	RIGHT_CLICK_ACTION_ENUM_NO_MOVEMENT_NORMAL_ATTACK = 3,
	RIGHT_CLICK_ACTION_ENUM_HARVEST = 4,
	RIGHT_CLICK_ACTION_ENUM_HARVEST_REPAIR = 5,
	RIGHT_CLICK_ACTION_ENUM_NOTHING_WITH_INDICATOR = 6
};

class unit_dimension_type_t:
	extends RefCounted
	var left: int;var up: int
	var right: int
	var down: int
	func _init(values: Array):
		left = values[0]
		up = values[1]
		right = values[2]
		down = values[3]

class special_ability_flags_type_t:
	extends RefCounted
	var building: bool
	var addon: bool
	var flyer: bool
	var resourceminer: bool
	var subunit: bool
	var flyingbuilding: bool
	var hero: bool
	var regenerate: bool
	var animatedidle: bool
	var cloakable: bool
	var twounitsinoneegg: bool
	var singleentity: bool
	var resourcedepot: bool
	var resourcecontainter: bool
	var robotic: bool
	var detector: bool
	var organic: bool
	var requirescreep: bool
	var unused: bool
	var requirespsi: bool
	var burrowable: bool
	var spellcaster: bool
	var permanentcloak: bool
	var pickupitem: bool
	var ignoresupplycheck: bool
	var usemediumoverlays: bool
	var uselargeoverlays: bool
	var battlereactions: bool
	var fullautoattack: bool
	var invincible: bool
	var mechanical: bool
	var producesunits: bool
	func _init(booleans: Array):
		building = booleans[0]
		addon = booleans[1]
		flyer = booleans[2]
		resourceminer = booleans[3]
		subunit = booleans[4]
		flyingbuilding = booleans[5]
		hero = booleans[6]
		regenerate = booleans[7]
		animatedidle = booleans[8]
		cloakable = booleans[9]
		twounitsinoneegg = booleans[10]
		singleentity = booleans[11]
		resourcedepot = booleans[12]
		resourcecontainter = booleans[13]
		robotic = booleans[14]
		detector = booleans[15]
		organic = booleans[16]
		requirescreep = booleans[17]
		unused = booleans[18]
		requirespsi = booleans[19]
		burrowable = booleans[20]
		spellcaster = booleans[21]
		permanentcloak = booleans[22]
		pickupitem = booleans[23]
		ignoresupplycheck = booleans[24]
		usemediumoverlays = booleans[25]
		uselargeoverlays = booleans[26]
		battlereactions = booleans[27]
		fullautoattack = booleans[28]
		invincible = booleans[29]
		mechanical = booleans[30]
		producesunits = booleans[31]

class group_flags_type_t:
	extends RefCounted
	var building: bool
	var factory: bool
	var independent: bool
	var men: bool
	var neutral: bool
	var protoss: bool
	var terran: bool
	var zerg: bool
	func _init(booleans: Array):
		building = booleans[0]
		factory = booleans[1]
		independent = booleans[2]
		men = booleans[3]
		neutral = booleans[4]
		protoss = booleans[5]
		terran = booleans[6]
		zerg = booleans[7]

func name_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.stat_txt_tbl_resource, _id)

func flingy() -> int:
	return _resource_manager.units_dat_resource.flingy[_id]

func flingy_obj() -> DatFlingy:
	return DatFlingy.new(_resource_manager, flingy())

func subunit1() -> int:
	return _resource_manager.units_dat_resource.subunit1[_id]
	
func subunit1_obj() -> DatUnit:
	var subunit1_var := subunit1()
	if subunit1_var == SUBUNIT_NONE:
		return null
	return DatUnit.new(_resource_manager, subunit1_var)

func infestation() -> int:
	if _id - BUILDING_START < 0:
		return ILLEGAL_INDEX
	return _resource_manager.units_dat_resource.infestation[_id - BUILDING_START]
	
func infestation_obj() -> DatUnit:
	var infestation_var := infestation()
	if infestation_var == ILLEGAL_INDEX:
		return null
	return DatUnit.new(_resource_manager, infestation_var)
	
func construction_animation() -> int:
	return _resource_manager.units_dat_resource.construction_animation[_id]
	
func construction_animation_obj() -> DatImage:
	var construction_animation_var := construction_animation()
	if construction_animation_var == CONSTRUCTION_NONE:
		return null
	return DatImage.new(_resource_manager, construction_animation_var)

func unit_direction() -> int:
	return _resource_manager.units_dat_resource.unit_direction[_id]
	
func shield_enable() -> bool:
	return _resource_manager.units_dat_resource.shield_enable[_id]
	
func shield_amount() -> int:
	return _resource_manager.units_dat_resource.shield_amount[_id]
	
func hit_points() -> int:
	return _resource_manager.units_dat_resource.hit_points[_id]
	
func elevation_level() -> int:
	return _resource_manager.units_dat_resource.elevation_level[_id]

func rank() -> int:
	return _resource_manager.units_dat_resource.rank[_id]
	
func ai_computer_idle() -> int:
	return _resource_manager.units_dat_resource.ai_computer_idle[_id]
	
func ai_computer_idle_obj() -> DatOrder:
	return DatOrder.new(_resource_manager, ai_computer_idle())
	
func ai_human_idle() -> int:
	return _resource_manager.units_dat_resource.ai_human_idle[_id]
	
func ai_human_idle_obj() -> DatOrder:
	return DatOrder.new(_resource_manager, ai_human_idle())
	
func ai_return_to_idle() -> int:
	return _resource_manager.units_dat_resource.ai_return_to_idle[_id]
	
func ai_return_to_idle_obj() -> DatOrder:
	return DatOrder.new(_resource_manager, ai_return_to_idle())
	
func ai_attack_unit() -> int:
	return _resource_manager.units_dat_resource.ai_attack_unit[_id]
	
func ai_attack_unit_obj() -> DatOrder:
	return DatOrder.new(_resource_manager, ai_attack_unit())
	
func ai_attack_move() -> int:
	return _resource_manager.units_dat_resource.ai_attack_move[_id]
	
func ai_attack_move_obj() -> DatOrder:
	return DatOrder.new(_resource_manager, ai_attack_move())
	
func ai_internal() -> int:
	return _resource_manager.units_dat_resource.ai_internal[_id]
	
func ai_internal_obj() -> DatOrder:
	return DatOrder.new(_resource_manager, ai_internal())
	
func ground_weapon() -> int:
	return _resource_manager.units_dat_resource.ground_weapon[_id]
	
func ground_weapon_obj() -> DatWeapon:
	return DatWeapon.new(_resource_manager, ground_weapon())
	
func air_weapon() -> int:
	return _resource_manager.units_dat_resource.air_weapon[_id]
	
func air_weapon_obj() -> DatWeapon:
	return DatWeapon.new(_resource_manager, air_weapon())
	
func special_ability_flags() -> special_ability_flags_type_t:
	var boolean_array := BitUtils.unpack_booleans_from_int32(_resource_manager.units_dat_resource.special_ability_flags[_id])
	var special_ability_flags_t = special_ability_flags_type_t.new(boolean_array)
	return special_ability_flags_t

func target_acquisition_range() -> int:
	return _resource_manager.units_dat_resource.target_acquisition_range[_id]
	
func sight_range() -> int:
	return _resource_manager.units_dat_resource.sight_range[_id]
	
func armor_upgrade() -> int:
	return _resource_manager.units_dat_resource.armor_upgrade[_id]

func unit_size() -> unit_size_enum_t:
	return _resource_manager.units_dat_resource.unit_size[_id]

func armor() -> int:
	return _resource_manager.units_dat_resource.armor[_id]

func right_click_action() -> right_click_action_enum_t:
	return _resource_manager.units_dat_resource.right_click_action[_id]
	
func right_click_action_obj() -> DatOrder:
	return DatOrder.new(_resource_manager, right_click_action())
	
func ready_sound() -> int:
	if not _resource_manager.units_dat_resource.ready_sound.size() > _id:
		return ILLEGAL_INDEX
	return _resource_manager.units_dat_resource.ready_sound[_id]

func ready_sound_obj() -> DatSfx:
	if ready_sound() == ILLEGAL_INDEX or ready_sound() == SOUND_NONE:
		return null
	return DatSfx.new(_resource_manager, ready_sound())

func what_sound_start() -> int:
	if not _resource_manager.units_dat_resource.what_sound_start.size() > _id:
		return ILLEGAL_INDEX
	return _resource_manager.units_dat_resource.what_sound_start[_id]

func what_sound_start_obj() -> DatSfx:
	if what_sound_start() == ILLEGAL_INDEX or what_sound_start() == SOUND_NONE:
		return null
	return DatSfx.new(_resource_manager, what_sound_start())
	
func what_sound_end() -> int:
	if not _resource_manager.units_dat_resource.what_sound_end.size() > _id:
		return ILLEGAL_INDEX
	return _resource_manager.units_dat_resource.what_sound_end[_id]

func what_sound_end_obj() -> DatSfx:
	if what_sound_end() == ILLEGAL_INDEX or what_sound_end() == SOUND_NONE:
		return null
	return DatSfx.new(_resource_manager, what_sound_end())
	
func piss_sound_start() -> int:
	if not _resource_manager.units_dat_resource.piss_sound_start.size() > _id:
		return ILLEGAL_INDEX
	return _resource_manager.units_dat_resource.piss_sound_start[_id]

func piss_sound_start_obj() -> DatSfx:
	if piss_sound_start() == ILLEGAL_INDEX or piss_sound_start() == SOUND_NONE:
		return null
	return DatSfx.new(_resource_manager, piss_sound_start())
	
func piss_sound_end() -> int:
	if not _resource_manager.units_dat_resource.piss_sound_end.size() > _id:
		return ILLEGAL_INDEX
	return _resource_manager.units_dat_resource.piss_sound_end[_id]

func piss_sound_end_obj() -> DatSfx:
	if piss_sound_end() == ILLEGAL_INDEX or piss_sound_end() == SOUND_NONE:
		return null
	return DatSfx.new(_resource_manager, piss_sound_end())
	
func yes_sound_start() -> int:
	if not _resource_manager.units_dat_resource.yes_sound_start.size() > _id:
		return ILLEGAL_INDEX
	return _resource_manager.units_dat_resource.yes_sound_start[_id]

func yes_sound_start_obj() -> DatSfx:
	if yes_sound_start() == ILLEGAL_INDEX or yes_sound_start() == SOUND_NONE:
		return null
	return DatSfx.new(_resource_manager, yes_sound_start())
	
func yes_sound_end() -> int:
	if not _resource_manager.units_dat_resource.yes_sound_end.size() > _id:
		return ILLEGAL_INDEX
	return _resource_manager.units_dat_resource.yes_sound_end[_id]

func yes_sound_end_obj() -> DatSfx:
	if yes_sound_end() == ILLEGAL_INDEX or yes_sound_end() == SOUND_NONE:
		return null
	return DatSfx.new(_resource_manager, yes_sound_end())
	
func unit_dimension() -> unit_dimension_type_t:
	var int_array := BitUtils.unpack_int16_from_int64(_resource_manager.units_dat_resource.unit_dimension[_id])
	var unit_dimension_t = unit_dimension_type_t.new(int_array)
	return unit_dimension_t

func portrait() -> int:
	return _resource_manager.units_dat_resource.portrait[_id]

func portrait_obj() -> DatPortrait:
	return DatPortrait.new(_resource_manager, portrait())

func mineral_cost() -> int:
	return _resource_manager.units_dat_resource.mineral_cost[_id]
	
func vespene_cost() -> int:
	return _resource_manager.units_dat_resource.vespene_cost[_id]
	
func build_time() -> int:
	return _resource_manager.units_dat_resource.build_time[_id]

func group_flags() -> group_flags_type_t:
	var boolean_array := BitUtils.unpack_booleans_from_byte(_resource_manager.units_dat_resource.group_flags[_id])
	var group_flags_t = group_flags_type_t.new(boolean_array)
	return group_flags_t

func supply_provided() -> int:
	return _resource_manager.units_dat_resource.supply_provided[_id]

func supply_required() -> int:
	return _resource_manager.units_dat_resource.supply_required[_id]
	
func space_provided() -> int:
	return _resource_manager.units_dat_resource.space_provided[_id]
	
func space_required() -> int:
	return _resource_manager.units_dat_resource.space_required[_id]
	
func build_score() -> int:
	return _resource_manager.units_dat_resource.build_score[_id]
	
func destroy_score() -> int:
	return _resource_manager.units_dat_resource.destroy_score[_id]
	
## hint: calling this in a plain starcraft non-broodwar data version always returns false
func broodwar_flag() -> bool:
	if is_format_bw():
		return false
	return _resource_manager.units_dat_resource.broodwar_flag[_id]
	
func is_format_bw() -> bool:
	return _resource_manager.units_dat_resource.is_format_bw
		

class_name WeaponResource
extends Resource

## commented export data containers are not (yet) used from the implementation

enum weapon_type_enum_t {
	WEAPON_TYPE_ENUM_NDEPENDENT = 0,
	WEAPON_TYPE_ENUM_EXPLOSIVE = 1,
	WEAPON_TYPE_ENUM_CONCUSSIVE = 2,
	WEAPON_TYPE_ENUM_NORMAL = 3,
	WEAPON_TYPE_ENUM_IGNORE_AMOR = 4
};

enum attack_type_enum_t {
	ATTACK_TYPE_ENUM_AIR_ONLY = 1,
	ATTACK_TYPE_ENUM_GROUND_ONLY = 2,
	ATTACK_TYPE_ENUM_GROUND_AND_AIR = 3,
	ATTACK_TYPE_ENUM_UNITS_ONLY = 4,
	ATTACK_TYPE_ENUM_GROUND_UNITS_ONLY = 18
};

@export var label: PackedInt32Array
@export var flingy: PackedInt32Array
@export var explosion: PackedByteArray
@export var target_flags: PackedInt32Array
@export var minimum_range: PackedInt32Array
@export var maximum_range: PackedInt32Array
@export var damage_upgrade: PackedByteArray
@export var weapon_type: PackedByteArray
@export var weapon_behaviour: PackedByteArray
@export var remove_after: PackedByteArray
@export var explosive_type: PackedByteArray
@export var inner_splash_range: PackedInt32Array
@export var medium_splash_range: PackedInt32Array
@export var outer_splash_range: PackedInt32Array
@export var damage_amount: PackedInt32Array
@export var damage_bonus: PackedInt32Array
@export var weapon_cooldown: PackedByteArray
@export var damage_factor: PackedByteArray
@export var attack_angle: PackedByteArray
@export var launch_spin: PackedByteArray
@export var x_offset: PackedByteArray
@export var y_offset: PackedByteArray
@export var error_message: PackedInt32Array
@export var icon: PackedInt32Array

func max_weapons() -> int:
	return label.size()

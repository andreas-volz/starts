class_name DatFlingy
extends DatObject

enum movement_control_enum_t {
		MOVEMENT_CONTROL_ENUM_FLINGY = 0,
		MOVEMENT_CONTROL_ENUM_WEAPON = 1,
		MOVEMENT_CONTROL_ENUM_ISCRIPT = 2
	};

func sprite() -> int:
	return _resource_manager.flingy_dat_resource.sprite[_id]

func sprite_obj() -> DatSprite:
	return DatSprite.new(_resource_manager, sprite())
	
func speed() -> int:
	return _resource_manager.flingy_dat_resource.speed[_id]
	
func acceleration() -> int:
	return _resource_manager.flingy_dat_resource.acceleration[_id]
	
func halt_distance() -> int:
	return _resource_manager.flingy_dat_resource.halt_distance[_id]
	
func turn_radius() -> int:
	return _resource_manager.flingy_dat_resource.turn_radius[_id]
	
func movement_control() -> movement_control_enum_t:
	return _resource_manager.flingy_dat_resource.movement_control[_id]

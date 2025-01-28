class_name DatTech
extends DatObject

enum race_enum_t {
	RACE_ENUM_ZERG = 0,
	RACE_ENUM_TERRAN = 1,
	RACE_ENUM_PROTOSS = 2,
	RACE_ENUM_ALL = 3
};

func mineral_cost() -> int:
	return _resource_manager.techdata_dat_resource.mineral_cost[_id]
	
func vespene_cost() -> int:
	return _resource_manager.techdata_dat_resource.vespene_cost[_id]
	
func research_time() -> int:
	return _resource_manager.techdata_dat_resource.research_time[_id]
	
func energy_required() -> int:
	return _resource_manager.techdata_dat_resource.energy_required[_id]
	
func icon() -> int:
	return _resource_manager.techdata_dat_resource.icon[_id]

func label() -> int:
	return _resource_manager.techdata_dat_resource.label[_id]

func label_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.stat_txt_tbl_resource, label() - 1)

func race() -> race_enum_t:
	return _resource_manager.techdata_dat_resource.race[_id]
	

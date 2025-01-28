class_name DatUpgrade
extends DatObject

func mineral_cost_base() -> int:
	return _resource_manager.upgrades_dat_resource.mineral_cost_base[_id]

func mineral_cost_factor() -> int:
	return _resource_manager.upgrades_dat_resource.mineral_cost_factor[_id]
	
func vespene_cost_base() -> int:
	return _resource_manager.upgrades_dat_resource.vespene_cost_base[_id]
	
func vespene_cost_factor() -> int:
	return _resource_manager.upgrades_dat_resource.vespene_cost_factor[_id]
	
func research_time_base() -> int:
	return _resource_manager.upgrades_dat_resource.research_time_base[_id]
	
func research_time_factor() -> int:
	return _resource_manager.upgrades_dat_resource.research_time_factor[_id]
	
func icon() -> int:
	return _resource_manager.upgrades_dat_resource.icon[_id]

func label() -> int:
	return _resource_manager.upgrades_dat_resource.label[_id]

func label_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.stat_txt_tbl_resource, label() - 1)

func race() -> int: # TODO: return enum
	return _resource_manager.upgrades_dat_resource.race[_id]
	
func max_repeats() -> int:
	return _resource_manager.upgrades_dat_resource.max_repeats[_id]
	

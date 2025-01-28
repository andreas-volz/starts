class_name DatOrder
extends DatObject

const HIGHLIGHT_NONE = 65535

func mineral_cost_base() -> int:
	return _resource_manager.upgrades_dat_resource.mineral_cost_base[_id]

func label() -> int:
	return _resource_manager.orders_dat_resource.label[_id]

func label_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.stat_txt_tbl_resource, label() - 1)

func use_weapon_targeting() -> bool:
	return _resource_manager.orders_dat_resource.use_weapon_targeting[_id]
	
func interruptible() -> bool:
	return _resource_manager.orders_dat_resource.interruptible[_id]
	
func queueable() -> bool:
	return _resource_manager.orders_dat_resource.queueable[_id]
	
func targeting() -> int:
	return _resource_manager.orders_dat_resource.targeting[_id]
	
func targeting_obj() -> DatWeapon:
	return DatWeapon.new(_resource_manager, targeting())
	
func energy() -> int:
	return _resource_manager.orders_dat_resource.energy[_id]
# TODO: TechData variant
	
func animation() -> int:
	return _resource_manager.orders_dat_resource.animation[_id]
	
func highlight() -> int:
	return _resource_manager.orders_dat_resource.highlight[_id]
	
func obscured_order() -> int:
	return _resource_manager.orders_dat_resource.obscured_order[_id]
	
func obscured_order_obj() -> DatOrder:
	return DatOrder.new(_resource_manager, obscured_order())
	
	

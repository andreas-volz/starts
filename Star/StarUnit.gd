class_name StarUnit
extends StarObject

var _dat: DatUnit : get=get_dat
var _star_flingy: StarFlingy
var _star_subunit1: StarUnit


func get_dat() -> DatUnit:
	return _dat

func load_id(unit_id, subunits: bool = true):
	var dat_unit := DatUnit.new(_resource_manager, unit_id)
	load_dat(dat_unit, subunits)

func load_dat(dat_unit: DatUnit, subunits: bool = true):
	_dat = dat_unit
	
	# only one object could be loaded otherwise free before
	if _star_flingy != null:
		_star_flingy.queue_free()
	
	_star_flingy = StarFlingy.new(_resource_manager)
	_star_flingy.load_dat(_dat.flingy_obj())
	add_child(_star_flingy)

	# only one subobject could be loaded otherwise free before
	if _star_subunit1 != null:
		_star_subunit1.queue_free()

	if subunits:
		var subunit1_obj = _dat.subunit1_obj()
		if subunit1_obj != null:
			_star_subunit1 = StarUnit.new(_resource_manager)
			_star_subunit1.load_dat(subunit1_obj)
			add_child(_star_subunit1)

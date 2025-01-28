class_name TechResource
extends Resource

## commented export data containers are not (yet) used from the implementation

@export var mineral_cost: PackedInt32Array
@export var vespene_cost: PackedInt32Array
@export var research_time: PackedInt32Array
@export var energy_required: PackedInt32Array
#@export var unknown4: PackedInt32Array
@export var icon: PackedInt32Array
@export var label: PackedInt32Array
@export var race: PackedByteArray
#@export var unused: PackedByteArray
@export var broodwar_flag: PackedByteArray
@export var has_broodwar_flag: bool

func max_energy() -> int:
	return label.size()

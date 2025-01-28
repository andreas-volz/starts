class_name DatObject
extends RefCounted

const ILLEGAL_INDEX: int = -1

var _resource_manager: ResourceManager
var _id: int

func _init(resource_manager: ResourceManager, id: int):
	_resource_manager = resource_manager
	_id = id

func get_id() -> int:
	return _id

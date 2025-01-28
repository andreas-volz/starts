class_name DatTbl
extends RefCounted

var _tbl_resource: TblResource
var _id: int

func _init(tbl_resource: TblResource, id: int) -> void:
	_tbl_resource = tbl_resource
	_id = id

func name1() -> String:
	return _tbl_resource.list[_id].name1

func name2() -> String:
	return _tbl_resource.list[_id].name2

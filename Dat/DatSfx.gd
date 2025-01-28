class_name DatSfx
extends DatObject

func sound_file() -> int:
	return _resource_manager.sfxdata_dat_resource.sound_file[_id]

func sound_file_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.sfxdata_tbl_resource, sound_file() - 1)

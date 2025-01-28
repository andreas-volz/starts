class_name DatPortrait
extends DatObject

func video_idle() -> int:
	return _resource_manager.portdata_dat_resource.video_idle[_id]
	
func video_idle_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.portdata_tbl_resource, video_idle() - 1)
	
func video_talking() -> int:
	return _resource_manager.portdata_dat_resource.video_talking[_id]
	
func video_talking_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.portdata_tbl_resource, video_talking() - 1)
	
func change_idle() -> int:
	return _resource_manager.portdata_dat_resource.change_idle[_id]
	
func change_idle_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.portdata_tbl_resource, change_idle() - 1)
	
func change_talking() -> int:
	return _resource_manager.portdata_dat_resource.change_talking[_id]

func change_talking_tbl() -> DatTbl:
	return DatTbl.new(_resource_manager.portdata_tbl_resource, change_talking() - 1)

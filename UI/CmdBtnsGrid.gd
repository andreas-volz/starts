class_name CommandBtnsGrid
extends GridContainer

const EMPTY_ICON = 22*17 # this is an empty area

var _resource_manager: ResourceManager

func _init_resources(resource_manager: ResourceManager) -> void:
	_resource_manager = resource_manager

	for child in get_children():
		child._init_resources(resource_manager)
		child.set_color(0)
		child.frame = EMPTY_ICON 

func clear():
	for child in get_children():
		child.frame = EMPTY_ICON 

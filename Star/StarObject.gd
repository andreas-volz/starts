class_name StarObject
extends Node2D

var _resource_manager: ResourceManager

var direction: int : set=set_direction, get=get_direction

func _init(resource_manager: ResourceManager = null):
	_resource_manager = resource_manager

func set_team_color(color_index: int):
	for child in get_children():
		child.set_team_color(color_index)

func set_direction(direction_param: int):
	direction = direction_param
	
	for child in get_children():
		child.direction = direction
		
func get_direction() -> int:
	return direction

func play(animation_type: IScript.AnimationType):
	for child in get_children():
		child.play(animation_type)

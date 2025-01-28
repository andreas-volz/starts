class_name DatSprite
extends DatObject

const SELECTABLE_SPRITE_START := 130
const SELECTABLE_IMAGE_START := 561

func image() -> int:
	if _id >= _resource_manager.sprites_dat_resource.image.size():
		push_warning("Try to place the image from not existing sprite (maybe from Broodwar): " + str(_id))
		return 0
	return _resource_manager.sprites_dat_resource.image[_id]

func image_obj() -> DatImage:
	return DatImage.new(_resource_manager, image())

func health_bar() -> int:
	if _id - SELECTABLE_SPRITE_START < 0:
		return ILLEGAL_INDEX
	#print("health_bar: ", _id, "-", SELECTABLE_SPRITE_START)
	return _resource_manager.sprites_dat_resource.health_bar[_id - SELECTABLE_SPRITE_START]
	
func is_visible() -> bool:
	return _resource_manager.sprites_dat_resource.is_visible[_id]
	
func select_circle_image_size() -> int:
	if _id - SELECTABLE_SPRITE_START < 0:
		return ILLEGAL_INDEX
	# TODO: this needs to be checked! Looks wrong in DatViewer
	#print("select_circle_image_size: ", _resource_manager.sprites_dat_resource.select_circle_image_size[_id - SELECTABLE_SPRITE_START])
	return _resource_manager.sprites_dat_resource.select_circle_image_size[_id - SELECTABLE_SPRITE_START] + SELECTABLE_IMAGE_START
	
func select_circle_image_size_obj() -> DatImage:
	var select_circle_image_size_var := select_circle_image_size() #+ SELECTABLE_IMAGE_START
	if select_circle_image_size_var == ILLEGAL_INDEX:
		return null
	return DatImage.new(_resource_manager, select_circle_image_size_var)
	
func select_circle_vertical_pos() -> int:
	if _id - SELECTABLE_SPRITE_START < 0:
		return ILLEGAL_INDEX
	return _resource_manager.sprites_dat_resource.select_circle_vertical_pos[_id - SELECTABLE_SPRITE_START]

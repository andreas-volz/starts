extends Node2D

var resource_manager: ResourceManager = ResourceManager.new()

func _ready() -> void:
	pass
	var star_image := StarImage.new(resource_manager)
	star_image.load_id(340)
	add_child(star_image)
	star_image.global_position = Vector2(200, 200)

	var star_sprite := StarSprite.new(resource_manager)
	star_sprite.load_id(78)
	add_child(star_sprite)
	star_sprite.global_position = Vector2(300, 300)

	var star_flingy := StarFlingy.new(resource_manager)
	star_flingy.load_id(7)
	add_child(star_flingy)
	star_flingy.global_position = Vector2(400, 400)
	
	var star_unit := StarUnit.new(resource_manager)
	star_unit.load_id(3)
	
	add_child(star_unit)
	star_unit.global_position = Vector2(450, 250)
	
	

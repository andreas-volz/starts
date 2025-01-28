@tool
class_name UISprite
extends Control

## The four properties below simulate those of `Sprite` nodes.
## Each uses a setter to update the node's bounds and draw the sprite correctly.
@export var texture: Texture: set=_set_texture

@export_category("Offset")
@export var centered := false : set=_set_centered
@export_category("Animation")
@export var hframes: int = 1  : set=_set_hframes
@export var vframes: int = 1  : set=_set_vframes
@export var frame: int = 0 : set=_set_frame
@export var frame_coords := Vector2i(0, 0) : set=_set_frame_coords
@export_category("Region")
@export var region_enabled: bool = false: set=_set_region_enabled
@export var region_rect: Rect2 = Rect2(): set=_set_region_rect
@export_category("")
@export var texture_scale := Vector2.ONE: set=_set_scale

var animation_rect: Rect2 = Rect2()

## Godot calls _draw() once when instantiating the node and toggling visibility.
## Otherwise, it displays whatever it drew last.
## To trigger a redraw, you can call the `CanvasItem.update()` method.
## We use Godot's drawing functions to draw the sprite either as a whole or with
## a region selected.
func _draw() -> void:
	if not texture:
		return

	var pivot := Vector2.ZERO
	if centered:
		pivot = -size/2
		
	if region_enabled:
		# Draws a texture within the node's bounding box. using the
		# `region_rect` to sample from the texture.
		#
		# Note that the `_draw()` function draws relative to its node's
		# position.
		# That's why we pass in `Vector2.ZERO` for the `Rect2`'s position below:
		# it means 'draw where this node is with no offset.'
		draw_texture_rect_region(texture, Rect2(Vector2.ZERO, size), region_rect, self_modulate)
	else:
		# Draws the entire texture inside the given rectangle on screen.
		if animation_rect:
			
			draw_texture_rect_region(texture, Rect2(pivot, size), animation_rect, self_modulate)

func _ready() -> void:
	size_flags_changed.connect(_on_size_flags_changed)
	resized.connect(_on_resized)

## Each setter sets the provided value, then calls `_update_region()` to force
## an update to the `Control` values.
func _set_texture(value: Texture) -> void:
	texture = value
	_update_region()


func _set_region_enabled(value: bool) -> void:
	region_enabled = value
	_update_region()


func _set_region_rect(value: Rect2) -> void:
	region_rect = value
	_update_region()


func _set_scale(value: Vector2) -> void:
	texture_scale = value
	_update_region()

func _set_hframes(value: int) -> void:
	hframes = value
	_update_region()
	
func _set_vframes(value: int) -> void:
	vframes = value
	_update_region()
	
func _set_frame(value: int) -> void:
	frame = value
	frame_coords.y = value / hframes
	frame_coords.x = frame - (frame_coords.y * hframes)
	_update_region()
	
func _set_frame_coords(value: Vector2i) -> void:
	frame_coords = value
	# TODO: setting frame coords doesn't update the frame value
	# this is not possible in Godot4. (infinite recursion - need to search a solution)
	#frame = frame_coords.y * hframes + frame_coords.x
	_update_region()
	
func _set_centered(value: bool):
	centered = value
	queue_redraw()
	
# Sets the Control's minimum rectangle size and prompts a texture redraw.
func _update_region() -> void:
	if region_enabled:
		size = region_rect.size * texture_scale
	else:
		if texture:
			animation_rect.size.x = texture.get_size().x / hframes
			animation_rect.size.y = texture.get_size().y / vframes
			animation_rect.position.x = animation_rect.size.x * frame_coords.x
			animation_rect.position.y = animation_rect.size.y * frame_coords.y
			size = animation_rect.size * texture_scale
			custom_minimum_size = size
		else:
			size = Vector2.ZERO

	# Asks Godot to call the `_draw()` function on the next drawing update.
	queue_redraw()

func _on_size_flags_changed():
	_update_region()

func _on_resized():
	_update_region()

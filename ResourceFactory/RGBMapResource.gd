class_name RGBMapResource
extends Resource

@export var colors: PackedByteArray

func get_rgb_array(index: int) -> Array[int]:
	index *= 3 # index is always a complete RGB 3-byte set
	var rgb_array: Array[int]
	if colors.size() > index + 2:
		rgb_array.push_back(colors[index])
		rgb_array.push_back(colors[index + 1])
		rgb_array.push_back(colors[index + 2])
	return rgb_array

static func get_color8_array(color8: Array) -> Color:
	var color: Color
	if color8.size() != 3:
		return color
	color.r8 = color8[0]
	color.g8 = color8[1]
	color.b8 = color8[2]
	color.a8 = 255
	return color

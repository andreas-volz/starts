class_name PaletteResource
extends Resource

## commented export data containers are not (yet) used from the implementation

@export var colors: PackedByteArray

func get_rgb_array(index: int) -> Array[int]:
	index *= 3 # index is always a complete RGB 3-byte set
	var rgb_array: Array[int]
	if colors.size() > index + 2:
		rgb_array.push_back(colors[index])
		rgb_array.push_back(colors[index + 1])
		rgb_array.push_back(colors[index + 2])
	return rgb_array

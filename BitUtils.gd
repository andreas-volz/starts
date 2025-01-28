class_name BitUtils
extends RefCounted

## 4 x int16 <=> int64

static func pack_int16_to_int64(values: Array) -> int:
	# Ensure the array contains exactly 4 elements
	assert(values.size() == 4, "The array must contain exactly 4 values.")
	# Each value must fit in the range [0, 65535] (16 bits)
	for value in values:
		assert(value >= 0 and value <= 0xFFFF, "Values must be between 0 and 65535.")

	# Pack the values into a single 64-bit integer
	var packed: int = 0
	for i in range(4):
		var value: int = values[i]
		packed |= (value & 0xFFFF) << (i * 16)
	return packed

static func unpack_int16_from_int64(packed: int) -> Array:
	# Unpack the 64-bit integer into an array of 4 values
	var values: Array = []
	for i in range(4):
		values.append((packed >> (i * 16)) & 0xFFFF)
	return values

static func create_packed_int64_array_from_int16(data: Array) -> PackedInt64Array:
	# Create a PackedInt64Array from an array of int arrays
	var packed_array = PackedInt64Array()
	for values in data:
		packed_array.append(pack_int16_to_int64(values))
	return packed_array

## 4 x int8 <=> int32

static func pack_int8_to_int32(values: Array) -> int:
	# Ensure the array contains exactly 4 elements
	assert(values.size() == 4, "The array must contain exactly 4 values.")
	# Each value must fit in the range [0, 255] (8 bits)
	for value in values:
		assert(value >= 0 and value <= 0xFF, "Values must be between 0 and 255.")

	# Pack the values into a single 32-bit integer
	var packed: int = 0
	for i in range(4):
		var value: int = values[i]
		packed |= (value & 0xFF) << (i * 8)
	return packed

static func unpack_int8_from_int32(packed: int) -> Array:
	# Unpack the 32-bit integer into an array of 4 values
	var values: Array = []
	for i in range(4):
		values.append((packed >> (i * 8)) & 0xFF)
	return values

static func create_packed_int32_array_from_int8(data: Array) -> PackedInt64Array:
	# Create a PackedInt32Array from an array of int arrays
	var packed_array = PackedInt32Array()
	for values in data:
		packed_array.append(pack_int16_to_int64(values))
	return packed_array

## 32 x boolean <=> int32

static func pack_booleans_to_int32(booleans: Array) -> int:
	# Ensure the array contains exactly 32 elements
	assert(booleans.size() == 32, "The array must contain exactly 32 values.")
	
	# Pack the values into a single 32-bit integer
	var packed: int = 0
	for i in range(32):
		# Set the corresponding bit if the boolean is true
		if booleans[i]:
			packed |= (1 << i)
	return packed

static func unpack_booleans_from_int32(packed: int) -> Array:
	# Extract 32 boolean values from the packed int32
	var booleans: Array = []
	for i in range(32):
		booleans.append((packed >> i) & 1 == 1)
	return booleans

static func create_packed_int32_array_from_booleans(data: Array) -> PackedInt32Array:
	# Create a PackedInt32Array from an array of boolean arrays
	var packed_array = PackedInt32Array()
	for booleans in data:
		packed_array.append(pack_booleans_to_int32(booleans))
	return packed_array

## 8 x boolean <=> byte

static func pack_booleans_to_byte(booleans: Array) -> int:
	# Ensure the array contains exactly 8 elements
	assert(booleans.size() == 8, "The array must contain exactly 8 values.")
	
	# Pack the values into a single 8-bit integer
	var packed: int = 0
	for i in range(8):
		# Set the corresponding bit if the boolean is true
		if booleans[i]:
			packed |= (1 << i)
	return packed

static func unpack_booleans_from_byte(packed: int) -> Array:
	# Extract 8 boolean values from the packed byte
	var booleans: Array = []
	for i in range(8):
		booleans.append((packed >> i) & 1 == 1)
	return booleans

static func create_packed_byte_array_from_booleans(data: Array) -> PackedByteArray:
	# Create a PackedByteArray from an array of boolean arrays
	var packed_array = PackedByteArray()
	for booleans in data:
		packed_array.append(pack_booleans_to_byte(booleans))
	return packed_array

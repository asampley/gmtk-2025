class_name Track
extends TileMapLayer

# Convert a pixel coordinate to a tile in the tilemap
func pixel_to_tile_coord(pixel: Vector2i) -> Vector2i:
	var tile_size := self.tile_set.tile_size

	@warning_ignore("integer_division")
	return Vector2i(
		pixel.x / tile_size.x - (0 if pixel.x >= 0 else 1),
		pixel.y / tile_size.y - (0 if pixel.y >= 0 else 1),
	)

# Returns the possible output directions given an input direction.
#
# Direction is a unit Vector2i.
func connections(tile: Vector2i, in_direction: Vector2i) -> Array[Vector2i]:
	var array: Array[Vector2i] = []
	
	var signs := self._sign_string(in_direction.x) + self._sign_string(in_direction.y)
	for data: Vector2i  in get_cell_tile_data(tile).get_custom_data("conn" + signs):
		array.append(data)
	return array

func _sign_string(x: int) -> String:
	if x == 0:
		return "0"
	elif x < 0:
		return "-"
	else:
		return "+"

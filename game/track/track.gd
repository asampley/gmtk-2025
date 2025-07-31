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
func connections(tile: Vector2i, direction: Vector2i) -> Array[Vector2i]:
	match direction:
		Vector2i.UP:
			return connections_up(tile)
		Vector2i.DOWN:
			return connections_down(tile)
		Vector2i.LEFT:
			return connections_left(tile)
		Vector2i.RIGHT:
			return connections_right(tile)
		_:
			# TODO should this error, or is an empty array catastrophic enough?
			return []

# Returns the possible output directions entering from the top
func connections_up(tile: Vector2i) -> Array[Vector2i]:
	return self.get_cell_tile_data(tile).get_custom_data("conn_up")

# Returns the possible output directions entering from the bottom
func connections_down(tile: Vector2i) -> Array[Vector2i]:
	return self.get_cell_tile_data(tile).get_custom_data("conn_down")

# Returns the possible output directions entering from the bottom
func connections_left(tile: Vector2i) -> Array[Vector2i]:
	return self.get_cell_tile_data(tile).get_custom_data("conn_left")

# Returns the possible output directions entering from the bottom
func connections_right(tile: Vector2i) -> Array[Vector2i]:
	return self.get_cell_tile_data(tile).get_custom_data("conn_right")

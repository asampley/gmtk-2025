extends TileMapLayer

# Convert a pixel coordinate to a tile in the tilemap
func pixel_to_tile_coord(pixel: Vector2i) -> Vector2i:
	var tile_size := self.tile_set.tile_size

	@warning_ignore("integer_division")
	return Vector2i(
		pixel.x / tile_size.x - (0 if pixel.x >= 0 else 1),
		pixel.y / tile_size.y - (0 if pixel.y >= 0 else 1),
	)

# Return the convergence *direction* for all branches.
#
# If moving onto the tile from this face, a branch can be selected.
#
# If moving onto the tile from another face, this face should be the output direction.
func tile_branch_convergence(tile: Vector2i) -> Vector2i:
	return self.get_cell_tile_data(tile).get_custom_data("start")

# Return a list of possible *directions*, not indexes.
func tile_branches(tile: Vector2i) -> Array[Vector2i]:
	return self.get_cell_tile_data(tile).get_custom_data("branches")

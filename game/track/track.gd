class_name Track
extends TileMapLayer

# Returns the possible output directions given an input direction.
#
# Direction is a unit Vector2i.
func connections(tile: Vector2i, in_direction: Vector2i) -> Array[Vector2i]:
	var array: Array[Vector2i] = []

	var signs := self._sign_string(in_direction.x) + self._sign_string(in_direction.y)

	var tile_data := get_cell_tile_data(tile)
	if tile_data == null: return array

	var custom_data : Array = tile_data.get_custom_data("conn" + signs)

	for data: Vector2i in custom_data:
		array.append(data)

	return array

func _sign_string(x: int) -> String:
	if x == 0:
		return "0"
	elif x < 0:
		return "-"
	else:
		return "+"

#Returns true if no tile present
func has_tile(tile: Vector2i, in_direction: Vector2i) -> bool:
	var tile_data := get_cell_tile_data(tile)
	return tile_data == null

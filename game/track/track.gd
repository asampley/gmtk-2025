class_name Track
extends TileMapLayer

const DIRECTIONS: Array[Vector2i] = [
	Vector2i( 0, -1),
	Vector2i( 1, -1),
	Vector2i( 1,  0),
	Vector2i( 1,  1),
	Vector2i( 0,  1),
	Vector2i(-1,  1),
	Vector2i(-1,  0),
	Vector2i(-1, -1),
]

func transform_vector2(tile: Vector2i, v: Vector2) -> Vector2:
	if is_cell_transposed(tile):
		var tmp := v.x
		v.x = v.y
		v.y = tmp
	if is_cell_flipped_h(tile): v *= Vector2(-1, 1)
	if is_cell_flipped_v(tile): v *= Vector2(1, -1)

	return v

func transform_inverse_vector2(tile: Vector2i, v: Vector2) -> Vector2:
	if is_cell_flipped_h(tile): v *= Vector2(-1, 1)
	if is_cell_flipped_v(tile): v *= Vector2(1, -1)
	if is_cell_transposed(tile):
		var tmp := v.x
		v.x = v.y
		v.y = tmp

	return v

func transform_vector2i(tile: Vector2i, v: Vector2i) -> Vector2i:
	if is_cell_transposed(tile):
		var tmp := v.x
		v.x = v.y
		v.y = tmp
	if is_cell_flipped_h(tile): v *= Vector2i(-1, 1)
	if is_cell_flipped_v(tile): v *= Vector2i(1, -1)

	return v

func transform_inverse_vector2i(tile: Vector2i, v: Vector2i) -> Vector2i:
	if is_cell_flipped_h(tile): v *= Vector2i(-1, 1)
	if is_cell_flipped_v(tile): v *= Vector2i(1, -1)
	if is_cell_transposed(tile):
		var tmp := v.x
		v.x = v.y
		v.y = tmp

	return v

# Returns the possible output directions given an input direction.
#
# Direction is a unit Vector2i.
func connections(tile: Vector2i, in_direction: Vector2i) -> Array[Vector2i]:
	var array: Array[Vector2i] = []

	var tile_data := get_cell_tile_data(tile)
	if tile_data == null: return array

	in_direction = transform_inverse_vector2i(tile, in_direction)

	var signs := self._sign_string(in_direction.x) + self._sign_string(in_direction.y)

	var custom_data : Array = tile_data.get_custom_data("conn" + signs)

	for data: Vector2i in custom_data:
		array.append(transform_vector2i(tile, data))

	return array

# Return an approximate normal for orienting the coaster
func normal(tile: Vector2i) -> Vector2i:
	var tile_data := get_cell_tile_data(tile)

	if tile_data == null:
		return Vector2i.ZERO

	return transform_vector2i(tile, tile_data.get_custom_data("normal") as Vector2i)

func _sign_string(x: int) -> String:
	if x == 0:
		return "0"
	elif x < 0:
		return "-"
	else:
		return "+"

func effect(tile: Vector2i) -> TrackEffect:
	var tile_data := get_cell_tile_data(tile)
	
	if tile_data == null:
		return null
	
	return tile_data.get_custom_data("effect")

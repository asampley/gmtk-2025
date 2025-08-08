extends State


@export var jumping_state: State
@export var falling_state: State
@export var stopped_state: State
@export var station_state: State
@export var moving_on_rails_sound_effect: AudioStream

var tile_pos: Vector2i = Vector2i.MAX
var in_direction: Vector2i
var out_direction: Vector2i
var transition: State
var track: Track
var stopped_time: float = 0
var sound_effect_index: int
var track_effect_to_sound_index_dict: Dictionary[TrackEffect, int] = {}
var entered_track_effect: bool


func prepare_state(collision_track: Track, collision_point: Vector2) -> void:
	track = collision_track
	tile_pos = track.local_to_map(track.to_local(collision_point))

func enter() -> void:
	super()
	assert(track)
	assert(tile_pos != Vector2i.MAX)
	var in_dir := -base_node.velocity
	in_direction = Track.DIRECTIONS.reduce(func(acc: Vector2i, d: Vector2i) -> Vector2:
		var available_directions := track.connections(tile_pos, d)
		if available_directions.size() > 0 && (Vector2i.ZERO == acc || abs(in_dir.angle_to(d)) < abs(in_dir.angle_to(acc))):
			return d
		else:
			return acc
	, Vector2i.ZERO)
	update_path(true)
	sound_effect_index = base_node.audio_player.play_sound_effect(moving_on_rails_sound_effect)

func exit() -> void:
	super()
	track = null
	tile_pos = Vector2i.MAX
	base_node.audio_player.stop_sound_effect(sound_effect_index)

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		return jumping_state
	if event.is_action_pressed("special_move"):
		base_node.nitro_activate()
	if ["move_up", "move_down", "move_left", "move_right"].any(func(k: String) -> bool: 
			return event.is_action_pressed(k)):
		var follow := base_node.path_follow
		var curve := base_node.path.curve
		var near := curve.sample_baked(follow.progress + 0.05)
		
		# If we are before the branch, update out_direction
		if (follow.global_position - near).dot(follow.global_position - curve.get_point_position(1)) > 0:
			var state := update_path(false)
			if state != null:
				return state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	base_node.apply_nitro(delta)
	var effect := track.effect(tile_pos)
	if effect:
		effect.effect(track, tile_pos, base_node, delta)
		if !entered_track_effect:
			base_node.audio_player.play_sound_effect(effect.sound_effect)
			entered_track_effect = true
	else:
		entered_track_effect = false
	var curve := base_node.path.curve
	var follow := base_node.path_follow
	
	# if velocity is against the path, we should update it
	var progress_direction := (curve.sample_baked(follow.progress + 1) - curve.sample_baked(follow.progress - 1)).normalized()
	if base_node.velocity.dot(progress_direction) < 0:
		flip()
	var new_progress := follow.progress + base_node.velocity.length() * delta
	if new_progress > curve.get_baked_length():
		new_progress -= curve.get_baked_length()
		tile_pos += out_direction
		in_direction = -out_direction
		var state := update_path(false)
		if state != null:
			# We haven't moved at this point, so we must
			base_node.position += base_node.velocity * delta
			return state
	var old_pos := base_node.global_position
	base_node.path_follow.progress = new_progress
	var gt := base_node.path_follow.global_transform
	base_node.global_transform = base_node.path_follow.global_transform
	
	# If we're upside down
	if (Vector2.UP.rotated(base_node.rotation)).dot(track.normal(tile_pos)) < 0:
		gt = gt * Transform2D.IDENTITY.rotated(PI).scaled(Vector2(-1, 1))
	base_node.global_transform = gt
	var direction := (base_node.global_position - old_pos).normalized()
	var dv := (self.gravity * Vector2i.DOWN).project(direction) * delta
	if dv.x != NAN && dv.y != NAN:
		base_node.velocity = base_node.velocity.length() * direction + dv
	if base_node.velocity.length() <= 10 * Globals.time_scale:
		stopped_time += delta
		if stopped_time > 5:
			return stopped_state
	else:
		stopped_time = 0
	return null

func flip() -> void:
	var temp := in_direction
	in_direction = out_direction
	out_direction = temp
	base_node.path_follow.progress_ratio = 1 - base_node.path_follow.progress_ratio
	update_path(false)

func get_direction(vector_in: Vector2) -> Vector2i:
	return (Vector2i(-vector_in) / 32).clampi(-1,1)

func calc_direction(available_directions: Array[Vector2i], motion: Vector2i) -> Vector2i:
	if motion == Vector2i.ZERO:
		return available_directions[0]
	else:
		return available_directions.reduce(func(acc: Vector2i, v: Vector2i) -> Vector2i:
			return acc if (acc - motion).length_squared() < (v - motion).length_squared() else v
		)

# estimate_progress assigns the progress as well, based on the current location
func update_path(estimate_progress: bool) -> State:
	assert(base_node.path.top_level)
	var curve := base_node.path.curve
	var available_directions := track.connections(tile_pos, in_direction)
	if available_directions.size() == 0:
		return falling_state
	out_direction = calc_direction(available_directions, calc_motion())
	var tile_as_global := track.to_global(track.map_to_local(tile_pos))
	curve.clear_points()
	curve.add_point(tile_as_global + in_direction * track.tile_set.tile_size * 0.5)
	curve.add_point(tile_as_global)
	curve.add_point(tile_as_global + out_direction * track.tile_set.tile_size * 0.5)
	
	if estimate_progress:
		print("Attaching with progress %s" % curve.get_closest_offset(self.global_position))
		base_node.path_follow.progress = curve.get_closest_offset(self.global_position)
	return null

func calc_motion() -> Vector2i:
	return (Input.is_action_pressed("move_up") as int * Vector2i.UP) \
			+ (Input.is_action_pressed("move_down") as int * Vector2i.DOWN) \
			+ (Input.is_action_pressed("move_left") as int * Vector2i.LEFT) \
			+ (Input.is_action_pressed("move_right") as int * Vector2i.RIGHT)

func entered_station(station: Station) -> State:
	print("Entered station: %s" % station)
	station_state.station = station
	return station_state

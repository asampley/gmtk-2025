extends State


@export var moving_on_rails_state: State
@export var stopped_state: State
@export var falling_sound: AudioStream
@export var landing_sound: AudioStream

var combo_sequence: Array[Globals.ComboButtons]
var base_combo_score: float
var combo_multiplier: float
var combo_count: int
var airtime: float
var gliding: bool = false
var gliding_gravity_min: float = 100
var glide_duration: float

func enter() -> void:
	super()
	combo_sequence = []
	EventBus.train_audio_requested.emit(falling_sound)

func exit() -> void:
	super()
	EventBus.train_audio_requested.emit(landing_sound)
	EventBus.combo_reset.emit()
	EventBus.screen_shake_increased.emit(base_node.velocity.length())
	base_node.deform(Vector2(0,1))
	boost_velocity()
	clear_combo_data()
	if gliding:
		base_node.glide_cooldown = base_node.stats.glide_cooldown
		gliding = false

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("stunt_key_1"):
		combo_sequence.append(Globals.ComboButtons.LEFT)
		EventBus.combo_button_pressed.emit(Globals.ComboButtons.LEFT, combo_sequence.size())
	elif event.is_action_pressed("stunt_key_2"):
		combo_sequence.append(Globals.ComboButtons.RIGHT)
		EventBus.combo_button_pressed.emit(Globals.ComboButtons.RIGHT, combo_sequence.size())
	elif event.is_action_pressed("stunt_key_3"):
		combo_sequence.append(Globals.ComboButtons.UP)
		EventBus.combo_button_pressed.emit(Globals.ComboButtons.UP, combo_sequence.size())
	elif event.is_action_pressed("stunt_key_4"):
		combo_sequence.append(Globals.ComboButtons.DOWN)
	elif event.is_action_pressed("special_move"):
		activate_glide()
	else:
		return
	var missed_combos: int = 0
	for combo: ComboTemplate in DataHandler.combo_resources:
		missed_combos += 1 if !match_combo(combo) else 0
	if missed_combos >= DataHandler.combo_resources.size():
		combo_sequence.clear()
		EventBus.combo_failed.emit()
		spawn_fly_in_text("Combo Failed!")
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	base_node.apply_nitro(delta)

	airtime += delta
	EventBus.airtime_changed.emit(airtime)
	if gliding:
		var reduced_gravity := maxf(gravity - base_node.stats.glide_movement_transfer * Globals.time_scale_squared, gliding_gravity_min * Globals.time_scale_squared)
		base_node.velocity.y += reduced_gravity * delta
		glide_duration -= delta * Globals.time_scale
		if glide_duration <= 0:
			gliding = false
			base_node.glide_cooldown = base_node.stats.glide_cooldown * Globals.time_scale
		#var current_angle := base_node.velocity.angle()
		#var glide_angle := deg_to_rad(base_node.stats.glide_movement_transfer)
		#var new_angle := current_angle + glide_angle
		#base_node.velocity.rotated(new_angle)
		#gravity_angle = Vector2(0, gravity)
		#base_node.velocity.y +=
	else:
		base_node.velocity.y += gravity * delta
	var collision := base_node.move_and_collide(base_node.velocity * delta)
	if collision && collision.get_collider() is Track:
		moving_on_rails_state.prepare_state(collision.get_collider(), collision.get_position())
		return moving_on_rails_state
	return null

func match_combo(combo: ComboTemplate) -> bool:
	if combo_sequence == combo.sequence:
		combo_count += 1
		base_node.set_animation(combo.animation_name)
		spawn_fly_in_text(combo.combo_name)
		combo_sequence.clear()
		base_combo_score += combo.base_score
		combo_multiplier += 1.0
		EventBus.combo_completed.emit(base_combo_score, combo_multiplier)
		return true
	for i in combo_sequence.size():
		if combo_sequence[i] != combo.sequence[i]:
			combo_multiplier = base_node.stats.base_combo_multiplier
			return false
	return true

func clear_combo_data() -> void:
	var final_score: float = (base_combo_score + airtime) * combo_multiplier
	Globals.money += final_score
	combo_count = 0
	EventBus.money_amount_changed.emit(Globals.money)
	base_combo_score = 0
	combo_multiplier = base_node.stats.base_combo_multiplier
	if airtime >= 1.0:
		spawn_fly_in_text("%s SECONDS AIRTIME" % snappedf(airtime, 0.01))
	airtime = 0
	EventBus.airtime_changed.emit(airtime)
	

func spawn_fly_in_text(text: String) -> void:
	var screen_transform := get_global_transform_with_canvas().get_origin()
	var vector := base_node.velocity.normalized()
	EventBus.generated_fly_in_text.emit(text, screen_transform + Vector2(0, -100), -vector)

func boost_velocity() -> void:
	var init_velocity := base_node.velocity
	base_node.velocity += base_node.stats.combo_boost * sqrt(combo_count) * base_node.velocity.normalized() * Globals.time_scale
	print("Combo boost: %s -> %s" % [ init_velocity, base_node.velocity ])

func activate_glide() -> void:
	gliding = true
	glide_duration = base_node.stats.glide_duration

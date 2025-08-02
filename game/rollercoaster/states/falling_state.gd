extends State


@export var moving_on_rails_state: State
@export var stopped_state: State
@export var falling_sound: AudioStream
@export var landing_sound: AudioStream

var combo_sequence: Array[Globals.ComboButtons]
var airtime: float

func enter() -> void:
	super()
	combo_sequence = []
	EventBus.audio_clip_requested.emit(falling_sound)

func exit() -> void:
	super()
	EventBus.audio_clip_requested.emit(landing_sound)
	EventBus.combo_reset.emit()
	EventBus.screen_shake_increased.emit(base_node.velocity.length())
	base_node.deform(Vector2(0,1))
	spawn_fly_in_text("%s SECONDS AIRTIME" % snappedf(airtime, 0.01))
	airtime = 0
	EventBus.airtime_changed.emit(airtime)

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
		EventBus.combo_button_pressed.emit(Globals.ComboButtons.DOWN, combo_sequence.size())
	else:
		return
	var missed_combos: int = 0
	for combo: ComboTemplate in DataHandler.combo_resources:
		var mismatch := false
		if combo_sequence == combo.sequence:
			base_node.set_animation(combo.animation_name)
			spawn_fly_in_text(combo.combo_name)
			combo_sequence.clear()
			EventBus.combo_completed.emit()
			Globals.money += 100
		for i in combo_sequence.size():
			if combo_sequence[i] != combo.sequence[i]:
				missed_combos += 1
				break
	if missed_combos >= DataHandler.combo_resources.size():
		combo_sequence.clear()
		EventBus.combo_failed.emit()
		spawn_fly_in_text("Combo Failed!")
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	airtime += delta
	EventBus.airtime_changed.emit(airtime)
	print("velocity = ", base_node.velocity)
	base_node.velocity.y += gravity * delta
	var collision := base_node.move_and_collide(base_node.velocity * delta)
	if collision && collision.get_collider() is Track:
		moving_on_rails_state.prepare_state(collision.get_collider(), collision.get_position())
		return moving_on_rails_state
	return null

func spawn_fly_in_text(text: String) -> void:
	var screen_transform := get_global_transform_with_canvas().get_origin()
	var vector := base_node.velocity.normalized()
	EventBus.generated_fly_in_text.emit(text, screen_transform + Vector2(0, -100), -vector)

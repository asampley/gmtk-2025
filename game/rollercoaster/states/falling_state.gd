extends State


@export var moving_on_rails_state: State
@export var stopped_state: State

enum ComboButtons { LEFT, RIGHT, UP, DOWN }
var combo_sequence: Array[ComboButtons]

func enter() -> void:
	super()
	base_node.set_colour(Color.YELLOW)
	combo_sequence = []

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if event.is_action_released("stunt_key_1"):
		combo_sequence.append(ComboButtons.LEFT)
		print("left")
	if event.is_action_released("stunt_key_2"):
		combo_sequence.append(ComboButtons.RIGHT)
		print("right")
	if event.is_action_released("stunt_key_3"):
		combo_sequence.append(ComboButtons.UP)
		print("up")
	if event.is_action_released("stunt_key_4"):
		combo_sequence.append(ComboButtons.DOWN)
		print("down")
	var missed_combos: int = 0
	for combo: ComboTemplate in DataHandler.combo_resources:
		var mismatch := false
		if combo_sequence == combo.sequence:
			spawn_fly_in_text(combo.combo_name)
			combo_sequence.clear()
		for i in combo_sequence.size():
			if combo_sequence[i] != combo.sequence[i]:
				missed_combos += 1
				break
	if missed_combos >= DataHandler.combo_resources.size():
		combo_sequence.clear()
		spawn_fly_in_text("Combo Failed!")
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	base_node.velocity.y += gravity * delta
	base_node.move_and_slide()
	if base_node.is_on_floor():
		return moving_on_rails_state
	return null

func spawn_fly_in_text(text: String) -> void:
	var screen_transform := get_global_transform_with_canvas().get_origin()
	var vector := base_node.velocity.normalized()
	EventBus.generated_fly_in_text.emit(text, screen_transform, -vector)

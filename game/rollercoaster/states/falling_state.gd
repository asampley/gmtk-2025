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
		
	for combo: ComboTemplate in DataHandler.combo_resources:
		print(combo.sequence)
		if combo_sequence == combo.sequence:
			EventBus.combo_completed.emit(combo.combo_name)
			print("combod")
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	base_node.velocity.y += gravity * delta
	base_node.move_and_slide()
	if base_node.is_on_floor():
		return moving_on_rails_state
	return null

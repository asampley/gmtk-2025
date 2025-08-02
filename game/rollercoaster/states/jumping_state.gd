extends State


@export var moving_on_rails_state: State
@export var falling_state: State
@export var jump_sound: AudioStream


func enter() -> void:
	super()
	base_node.velocity.y += -base_node.stats.jump_force
	EventBus.audio_clip_requested.emit(jump_sound, false)

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if base_node.velocity.y > 0:
		return falling_state
	return null

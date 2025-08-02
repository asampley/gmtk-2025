extends State


@export var moving_on_rails_state: State


func enter() -> void:
	super()

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	base_node.velocity.y += gravity * delta
	var collision := base_node.move_and_collide(base_node.velocity * delta)
	if collision && collision.get_collider() is Track:
		moving_on_rails_state.prepare_state(collision.get_collider(), collision.get_position())
		return moving_on_rails_state
	return null

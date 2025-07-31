extends State


@export var moving_on_rails_state: State
@export var stopped_state: State

var entered_stopped_state: float
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")


func enter() -> void:
	super()
	base_node.set_colour(Color.YELLOW)
	entered_stopped_state = Time.get_ticks_msec()

func exit() -> void:
	super()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var base_node_as_characterbody := base_node as CharacterBody2D
	base_node_as_characterbody.velocity.y += gravity * delta
	base_node_as_characterbody.move_and_slide()
	if base_node_as_characterbody.is_on_floor():
		return moving_on_rails_state
	return null

class_name StateMachine
extends Node

@export var starting_state: State

var current_state: State

func initialize(base_node_in: Node2D) -> void:
	for child in get_children():
		child.initialize(base_node_in)
	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	print("Entered state %s" % current_state)
	current_state.enter()

func process_physics(delta: float) -> void:
	try_change_state(current_state.process_physics(delta))

func process_input(event: InputEvent) -> void:
	try_change_state(current_state.process_input(event))

func process_frame(delta: float) -> void:
	try_change_state(current_state.process_frame(delta))

# Call when a station is entered
func entered_station(station: Station) -> void:
	try_change_state(current_state.entered_station(station))

func try_change_state(state: State) -> void:
	if state:
		change_state(state)

class_name StateMachine
extends Node

@export var startingState: State

var currentState: State

func initialize(baseNodeIn: Node2D) -> void:
	for child in get_children():
		child.initialize(baseNodeIn)
	change_state(startingState)

func change_state(newState: State) -> void:
	if currentState:
		currentState.exit()
	currentState = newState
	currentState.enter()

func process_physics(delta: float) -> void:
	var newState = currentState.process_physics(delta)
	if newState:
		change_state(newState)

func process_input(event: InputEvent) -> void:
	var newState = currentState.process_input(event)
	if newState:
		change_state(newState)

func process_frame(delta: float) -> void:
	var newState = currentState.process_frame(delta)
	if newState:
		change_state(newState)

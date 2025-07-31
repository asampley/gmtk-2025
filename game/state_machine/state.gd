class_name State
extends Node2D


@export var animation_name: String = "default"

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var base_node: Node2D

func initialize(base_node_in: Node2D) -> void:
	base_node = base_node_in

func enter() -> void:
	base_node.set_animation(animation_name)
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

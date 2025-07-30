class_name State
extends Node2D


@export var animationName: String = "default"


var baseNode: Unit

func initialize(baseNodeIn: Unit):
	baseNode = baseNodeIn

func enter() -> void:
	baseNode.set_animation(animationName)
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

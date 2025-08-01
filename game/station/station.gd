class_name Station
extends Node

@export var stop_tile: Vector2i
@export var in_direction: Vector2i = Vector2i.LEFT
@export var out_direction: Vector2i = Vector2i.RIGHT

func _on_body_entered(body: Node2D) -> void:
	print("here")
	if body is Rollercoaster:
		body.state_machine.entered_station(self)

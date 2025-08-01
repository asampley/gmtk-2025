@tool

extends Node

@export var pickup: PickupResource:
	set(v):
		pickup = v
		setup()

@export var sprite: Sprite2D:
	set(v):
		sprite = v
		setup()

@export var path_follow: PathFollow2D
@export var animate_speed: float = 8.0

func setup() -> void:
	if sprite:
		sprite.texture = pickup.texture if pickup else null

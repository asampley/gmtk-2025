class_name TrackEffectBoost
extends TrackEffect

@export var acceleration: Vector2

func effect(coaster: Rollercoaster, delta: float) -> void:
	print("Acceleration time!")
	print(coaster.velocity)
	coaster.velocity += acceleration * delta
	print(coaster.velocity)

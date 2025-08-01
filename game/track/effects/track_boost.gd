class_name TrackEffectBoost
extends TrackEffect

@export var acceleration: Vector2

func effect(track: Track, tile: Vector2i, coaster: Rollercoaster, delta: float) -> void:
	print("Acceleration time!")
	print(coaster.velocity)
	coaster.velocity += track.transform_vector2i(tile, acceleration) * delta
	print(coaster.velocity)

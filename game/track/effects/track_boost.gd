class_name TrackEffectBoost
extends TrackEffect

@export var acceleration: Vector2
@export var stop_at_goal: bool
@export var goal_velocity: Vector2

func effect(track: Track, tile: Vector2i, coaster: Rollercoaster, delta: float) -> void:
	var a := track.transform_vector2(tile, acceleration) * Globals.time_scale_squared
	var g := track.transform_vector2(tile, goal_velocity) * Globals.time_scale

	var start_velocity := coaster.velocity
	var next_velocity := coaster.velocity + a * delta

	if stop_at_goal && (g - next_velocity).length_squared() > (g - start_velocity).length_squared():
		return

	coaster.velocity = next_velocity

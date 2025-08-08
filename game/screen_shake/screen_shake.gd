extends Node2D


@export var shake_divisor: float = 1.5
@export var max_shake: float = 1000
@export var base_shake_fade: float = 1.0
var shake_strength: float = 0


var camera: Camera2D

func _ready() -> void:
	camera = get_parent()
	EventBus.screen_shake_increased.connect(on_screen_shake_increased)

func _process(delta: float) -> void:
	if shake_strength > 0:
		var shake_fade: float = base_shake_fade * 2
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		camera.offset = random_offset()
	if shake_strength <= 0:
		camera.offset = Vector2(0, 0)

func on_screen_shake_increased(intensity: float) -> void:
	shake_strength += intensity / shake_divisor
	shake_strength = clampf(shake_strength, 0, max_shake)

func random_offset() -> Vector2:
	var rng := RandomNumberGenerator.new()
	var x_offset := rng.randf_range(-shake_strength / camera.zoom.x, shake_strength / camera.zoom.x)
	var y_offset := rng.randf_range(-shake_strength / camera.zoom.y, shake_strength / camera.zoom.y)
	return Vector2(x_offset, y_offset)

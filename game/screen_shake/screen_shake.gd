extends Node2D


@export var shakeMultiplier: float = 1.5
var shakeStrength: float = 0
var baseShakeFade: float = 1
var camera: Camera2D

func _ready() -> void:
	camera = get_parent()
	EventBus.screen_shake_increased.connect(on_screen_shake_increased)

func _process(delta: float) -> void:
	if shakeStrength > 0:
		var shakeFade: float = baseShakeFade * 2
		shakeStrength = lerpf(shakeStrength, 0, shakeFade * delta)
		camera.offset = random_offset()
	if shakeStrength <= 0:
		camera.offset = Vector2(0, 0)

func on_screen_shake_increased(intensity: float) -> void:
	shakeStrength += intensity * shakeMultiplier

func random_offset() -> Vector2:
	var rng := RandomNumberGenerator.new()
	return Vector2(rng.randf_range(-shakeStrength, shakeStrength),rng.randf_range(-shakeStrength, shakeStrength))

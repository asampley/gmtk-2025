extends Control

@export var animate_duration: float

var animate: bool
var animation_time: float

func _ready() -> void:
	EventBus.to_the_moon.connect(start_animation)
	modulate = Color(1, 1, 1, 0)
	hide()

func _process(delta: float) -> void:
	if animate:
		animation_time += delta
		if animation_time > animate_duration:
			animate = false
			modulate = Color(1, 1, 1, 1)
		elif animation_time > 0:
			modulate = Color(1, 1, 1, animation_time / animate_duration)

func start_animation() -> void:
	show()
	animate = true
	animation_time = 0

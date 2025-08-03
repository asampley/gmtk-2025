extends Sprite2D

@export var time_until_animate: float
@export var animate_duration: float

var animate: bool
var animation_time: float

func _ready() -> void:
	EventBus.to_the_moon.connect(to_the_moon)
	start_animation()

func _process(delta: float) -> void:
	if animate:
		animation_time += delta

		if animation_time > animate_duration:
			animate = false
			visible = false
		elif animation_time > 0:
			visible = true
			scale = Vector2(sin(PI * animation_time / animate_duration), sin(PI * animation_time / animate_duration))
			rotation = TAU * animation_time / animate_duration


func to_the_moon() -> void:
	start_animation()

func start_animation() -> void:
	animate = true
	animation_time = -time_until_animate

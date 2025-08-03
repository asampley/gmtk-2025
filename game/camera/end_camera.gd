extends Camera2D

func _ready() -> void:
	EventBus.to_the_moon.connect(to_the_moon)

func to_the_moon() -> void:
	enabled = true

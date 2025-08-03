extends AudioStreamPlayer


@export var moving_sound: AudioStream


func _ready() -> void:
	EventBus.start_train_moving_sound.connect(on_start_playing_sound)
	EventBus.stop_train_moving_sound.connect(on_stop_playing_sound)

func on_start_playing_sound() -> void:
	stream = moving_sound
	play()

func on_stop_playing_sound() -> void:
	stop()

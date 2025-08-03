extends AudioStreamPlayer

@export var stopaudio: AudioStream
@export var moving_sound := AudioStream
@export var falling_sound := AudioStream
@export var jump_sound := AudioStream
@export var landing_sound: AudioStream


func _ready() -> void:
	EventBus.train_audio_requested.connect(on_train_audio_requested)

func on_train_audio_requested(clip: AudioStream) -> void:
	if clip == moving_sound:
		stream = clip
		play()
	elif clip == falling_sound:
		stream = clip
		play()
	elif clip == jump_sound:
		stream = clip
		play()
	elif clip == landing_sound:
		stream = clip
		play()
	elif clip == stopaudio:
		stop()
		stream.loop = false

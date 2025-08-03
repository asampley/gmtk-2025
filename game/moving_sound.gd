extends AudioStreamPlayer

@export var stopaudio: AudioStream
@export var moving_sound := AudioStream


func _ready() -> void:
	EventBus.train_audio_requested.connect(on_train_audio_requested)

func on_train_audio_requested(clip: AudioStream) -> void:
	if clip == moving_sound:
		stream = clip
		play()
	else:
		stop()
		stream.loop = false

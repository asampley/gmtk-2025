extends AudioStreamPlayer

@export var stopaudio: AudioStream

@export var falling_sound := AudioStream
@export var jump_sound := AudioStream
@export var landing_sound: AudioStream


func _ready() -> void:
	EventBus.train_audio_requested.connect(on_train_audio_requested)

func on_train_audio_requested(clip: AudioStream) -> void:
	stream = clip
	play()

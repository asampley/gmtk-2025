extends AudioStreamPlayer

func _ready() -> void:
	EventBus.audio_clip_requested.connect(on_audio_clip_requested)

func on_audio_clip_requested(clip: AudioStream) -> void:
	stream = clip
	play()

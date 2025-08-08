class_name PolyphonicAudioPlayer
extends AudioStreamPlayer


@export var custom_max_polyphony: int = 32


func _ready() -> void:
	stream = AudioStreamPolyphonic.new()
	stream.polyphony = custom_max_polyphony

func play_sound_effect(sound_effect: AudioStream) -> int:
	if sound_effect == null:
		return -1
	if !playing:
		play()
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = get_stream_playback()
	return polyphonic_stream_playback.play_stream(sound_effect)

func stop_sound_effect(sound_effect_index: int) -> void:
	if !playing:
		return
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = get_stream_playback()
	polyphonic_stream_playback.stop_stream(sound_effect_index)

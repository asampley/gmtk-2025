extends AudioStreamPlayer


@export var custom_max_polyphony: int = 32

@export_group("Sound Effects")
@export var success_sound: AudioStream
@export var failure_sound: AudioStream
@export var one_button: AudioStream
@export var two_buttons: AudioStream
@export var three_buttons: AudioStream
@export var four_buttons: AudioStream
@export var five_buttons: AudioStream
@export var six_buttons: AudioStream
@export var seven_buttons: AudioStream


func _ready() -> void:
	stream = AudioStreamPolyphonic.new()
	stream.polyphony = custom_max_polyphony
	EventBus.combo_button_pressed.connect(on_combo_button_pressed)
	EventBus.combo_completed.connect(on_combo_completed)
	EventBus.combo_failed.connect(on_combo_failed)

func on_combo_button_pressed(_combo_button: Globals.ComboButtons, length: int) -> void:
	var sound_effect: AudioStream
	match length:
		1:
			sound_effect = one_button
		2:
			sound_effect = two_buttons
		3:
			sound_effect = three_buttons
		4:
			sound_effect = four_buttons
		5:
			sound_effect = five_buttons
		6:
			sound_effect = six_buttons
		7:
			sound_effect = seven_buttons
	if !playing:
		play()
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = get_stream_playback()
	polyphonic_stream_playback.play_stream(sound_effect) 

func on_combo_completed(_combo_name: String, _score: float, _mult: float) -> void:
	if !playing:
		play()
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = get_stream_playback()
	polyphonic_stream_playback.play_stream(success_sound) 
	#stream = success_sound
	#play()

func on_combo_failed() -> void:
	if !playing:
		play()
	var polyphonic_stream_playback: AudioStreamPlaybackPolyphonic = get_stream_playback()
	polyphonic_stream_playback.play_stream(success_sound) 
	#stream = failure_sound
	#play()

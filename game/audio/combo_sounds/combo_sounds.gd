extends AudioStreamPlayer


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
	EventBus.combo_button_pressed.connect(on_combo_button_pressed)
	EventBus.combo_completed.connect(on_combo_completed)
	EventBus.combo_failed.connect(on_combo_failed)

func on_combo_button_pressed(_combo_button: Globals.ComboButtons, length: int) -> void:
	match length:
		1:
			stream = one_button
		2:
			stream = two_buttons
		3:
			stream = three_buttons
		4:
			stream = four_buttons
		5:
			stream = five_buttons
		6:
			stream = six_buttons
		7:
			stream = seven_buttons
	play()

func on_combo_completed() -> void:
	stream = success_sound
	play()

func on_combo_failed() -> void:
	stream = failure_sound
	play()

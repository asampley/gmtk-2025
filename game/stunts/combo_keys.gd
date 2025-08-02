class_name ComboButtonsViewer
extends Control

@onready var button_icon_parent: HBoxContainer = %ButtonIconParent

@export var left_button_texture: Texture2D
@export var right_button_texture: Texture2D
@export var up_button_texture: Texture2D
@export var down_button_texture: Texture2D


func _ready() -> void:
	EventBus.combo_button_pressed.connect(on_combo_button_pressed)
	EventBus.combo_completed.connect(on_combo_completed)
	EventBus.combo_failed.connect(on_combo_reset)
	EventBus.combo_reset.connect(on_combo_reset)

func on_combo_button_pressed(button: Globals.ComboButtons, _length: int) -> void:
	var button_icon := TextureRect.new()
	button_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	match button:
		Globals.ComboButtons.LEFT:
			button_icon.texture = left_button_texture
		Globals.ComboButtons.RIGHT:
			button_icon.texture = right_button_texture
		Globals.ComboButtons.UP:
			button_icon.texture = up_button_texture
		Globals.ComboButtons.DOWN:
			button_icon.texture = down_button_texture
	button_icon_parent.add_child(button_icon)
	show()

func on_combo_completed(_score: float, _mult: float) -> void:
	on_combo_reset()

func on_combo_reset() -> void:
	hide()
	for child: Node in button_icon_parent.get_children():
		child.queue_free()

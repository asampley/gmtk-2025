extends PanelContainer


@export var left_button_texture: Texture2D
@export var right_button_texture: Texture2D
@export var up_button_texture: Texture2D
@export var down_button_texture: Texture2D

@onready var combo_name: Label = %ComboName
@onready var button_icon_parent: GridContainer = %ButtonIconParent


func initialize(combo: ComboTemplate) -> void:
	combo_name.text = combo.combo_name
	for button in combo.sequence:
		populate_keys(button as Globals.ComboButtons)

func populate_keys(button: Globals.ComboButtons) -> void:
	var button_icon := TextureRect.new()
	button_icon.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
	button_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	button_icon.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button_icon.size_flags_vertical = Control.SIZE_EXPAND_FILL
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

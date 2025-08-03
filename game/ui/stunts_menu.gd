extends Control


@export var combo_viewer_prefab: PackedScene
@onready var stunts_parent: HBoxContainer = %StuntsParent
@onready var open_stunts_button: SoundButton = %OpenStuntsButton
@onready var glowy_text: Label = %GlowyText



func _ready() -> void:
	stunts_parent.hide()
	for combo in DataHandler.combo_resources:
		var combo_viewer := combo_viewer_prefab.instantiate()
		stunts_parent.add_child(combo_viewer)
		combo_viewer.initialize(combo)

func _on_open_stunts_toggled(toggled_on: bool) -> void:
	glowy_text.hide()
	stunts_parent.visible = toggled_on
	if toggled_on:
		open_stunts_button.text = "Hide Combos"
	else:
		open_stunts_button.text = "Show Combos"

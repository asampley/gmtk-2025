class_name UpgradeSelector
extends PanelContainer


@export var success_sound: AudioStream
@export var fail_sound: AudioStream 

@onready var icon: TextureRect = %Icon
@onready var cost: Label = %Cost

var upgrade: Upgrade


func initialize(upgrade_in: Upgrade) -> void:
	upgrade = upgrade_in
	icon.texture = upgrade.template.purchase_icon
	cost.text = str(upgrade.next_tier().cost)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		if Globals.money >= upgrade.next_tier().cost:
			EventBus.upgrade_purchased.emit(upgrade)
			EventBus.play_ui_sound.emit(success_sound)
		else:
			EventBus.play_ui_sound.emit(fail_sound)
			print_debug("Not enough money")

func _on_mouse_entered() -> void:
	EventBus.tooltip_requested.emit(upgrade.template.description, get_global_mouse_position())

func _on_mouse_exited() -> void:
	EventBus.tooltip_hidden.emit()

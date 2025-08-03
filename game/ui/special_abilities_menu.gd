extends Control

@onready var glide_cooldown: TextureProgressBar = %GlideCooldown
@onready var use_button: Label = %UseButton
@onready var nitro_cooldown: TextureProgressBar = %NitroCooldown



func _ready() -> void:
	EventBus.glide_cooldown_changed.connect(on_glide_cooldown_changed)
	EventBus.nitro_cooldown_changed.connect(on_nitro_cooldown_changed)
	EventBus.station_stop.connect(on_need_hide)
	EventBus.shop_menu_closed.connect(on_need_show)

func on_glide_cooldown_changed(amount: float) -> void:
	glide_cooldown.value = amount

func on_nitro_cooldown_changed(amount: float) -> void:
	nitro_cooldown.value = amount
	if amount == 0:
		use_button.show()
	else:
		use_button.hide()

func on_need_hide() -> void:
	hide()

func on_need_show() -> void:
	show()

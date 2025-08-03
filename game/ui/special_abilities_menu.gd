extends Control

@onready var glide_cooldown: TextureProgressBar = %GlideCooldown
@onready var nitro_cooldown: TextureProgressBar = %NitroCooldown


func _ready() -> void:
	EventBus.glide_cooldown_changed.connect(on_glide_cooldown_changed)
	EventBus.nitro_cooldown_changed.connect(on_nitro_cooldown_changed)

func on_glide_cooldown_changed(amount: float) -> void:
	glide_cooldown.value = amount

func on_nitro_cooldown_changed(amount: float) -> void:
	nitro_cooldown.value = amount

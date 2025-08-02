extends Control

@onready var glide_cooldown: TextureProgressBar = %GlideCooldown


func _ready() -> void:
	EventBus.glide_cooldown_changed.connect(on_glide_cooldown_changed)

func on_glide_cooldown_changed(amount: float) -> void:
	glide_cooldown.value = amount

extends Node


@export var fly_in_text_prefab: PackedScene
@export var fly_in_text_parent: Control


func _ready() -> void:
	EventBus.generated_fly_in_text.connect(on_generated_fly_in_text)

func on_generated_fly_in_text(position: Vector2, text: String) -> void:
	var fly_in_text: Label = fly_in_text_prefab.instantiate()
	add_child(fly_in_text)
	fly_in_text.global_position = position
	fly_in_text.initialize(text)

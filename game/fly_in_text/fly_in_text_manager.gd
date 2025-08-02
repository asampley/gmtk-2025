extends Node


@export var fly_in_text_prefab: PackedScene
@export var fly_in_text_parent: Control
@export var text_speed := 10.0


func _ready() -> void:
	EventBus.generated_fly_in_text.connect(on_generated_fly_in_text)

func on_generated_fly_in_text(text: String, position: Vector2, direction: Vector2 = Vector2(0,-1)) -> void:
	var fly_in_text: Label = fly_in_text_prefab.instantiate()
	fly_in_text_parent.add_child(fly_in_text)
	fly_in_text.position = position
	fly_in_text.initialize(text)
	print(fly_in_text.material.get_rid())
	fly_in_text.material = fly_in_text.material.duplicate()
	print(fly_in_text.material.get_rid())
	fly_in_text.material.set("shader_parameter/speed", text_speed)
	fly_in_text.material.set("shader_parameter/direction", direction)

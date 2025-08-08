extends Area2D


@export var should_self_fire: bool
@export var text: String
@export var popup_text_type: int = 0
@export var spawn_on_body: bool
@export var duration_seconds: float



func _on_body_entered(body: Node2D) -> void:
	if should_self_fire:
		call_popup_text(body)
	else:
		if body.has_method("call_popup_text"):
			body.call_popup_text(text, popup_text_type, duration_seconds)

func call_popup_text(body: Node2D) -> void:
	if spawn_on_body:
		EventBus.popup_text_requested.emit(text, popup_text_type, body.position, duration_seconds)
	else:
		EventBus.popup_text_requested.emit(text, popup_text_type, position, duration_seconds)
	

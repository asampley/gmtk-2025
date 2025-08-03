extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	print("To the moon!")
	EventBus.to_the_moon.emit()

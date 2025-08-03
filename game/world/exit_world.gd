extends Area2D

func _on_body_entered(_body:Node2D) -> void:
	print("here")
	EventBus.station_stop.emit()


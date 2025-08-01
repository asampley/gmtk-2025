extends Control


func _ready() -> void:
	EventBus.station_stop.connect(on_station_stop)
	EventBus.shop_menu_closed.connect(on_shop_menu_closed)

func on_station_stop() -> void:
	EventBus.objective_menu_requested.emit()
	show()

func on_shop_menu_closed() -> void:
	hide()

extends PanelContainer

@onready var money_text: Label = %MoneyText
@onready var speed_text: Label = %SpeedText
@onready var airtime_text: Label = %AirtimeText


func _ready() -> void:
	EventBus.money_amount_changed.connect(on_money_amount_changed)
	EventBus.speed_update.connect(on_speed_update)
	EventBus.airtime_changed.connect(on_airtime_changed)
	EventBus.station_stop.connect(on_stopped_at_station)
	EventBus.shop_menu_closed.connect(on_shop_menu_closed)

func on_money_amount_changed(money: int) -> void:
	money_text.text = "Money: %i" % money

func on_speed_update(speed: float) -> void:
	speed_text.text = "Speed: %s m/s" % snappedf(speed, 0.1)

func on_airtime_changed(airtime: float) -> void:
	airtime_text.text = "Airtime: %s s" % snappedf(airtime, 0.01)

func on_stopped_at_station() -> void:
	hide()

func on_shop_menu_closed() -> void:
	show()

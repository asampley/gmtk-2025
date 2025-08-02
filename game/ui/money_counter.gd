extends PanelContainer

@onready var money_text: Label = %MoneyText

func _process(_delta: float) -> void:
	money_text.text = "Money: %s" % Globals.money

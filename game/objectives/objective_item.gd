extends PanelContainer


@onready var title: Label = %Title
@onready var claim: TextureButton = %Claim


var objective: Objective

func initialize(objective_in: Objective) -> void:
	objective = objective_in
	title.text = objective.template.title
	if !objective.completed:
		claim.disabled = true
	
func _on_claim_pressed() -> void:
	Globals.money += objective.template.reward
	objective.claim()
	EventBus.objective_menu_requested.emit()

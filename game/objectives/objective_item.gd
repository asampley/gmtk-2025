extends PanelContainer


@onready var title: Label = %Title
@onready var claim: TextureButton = %Claim
@onready var bookmark: TextureButton = %Bookmark
@onready var highlight: TextureRect = %Highlight

var objective: Objective


func initialize(objective_in: Objective) -> void:
	objective = objective_in
	title.text = objective.template.title
	if !objective.completed:
		claim.disabled = true
		highlight.hide()
	if Globals.bookmarked_objective == objective:
		bookmark.disabled = true

func _on_claim_pressed() -> void:
	Globals.money += objective.template.reward
	objective.claim()
	EventBus.objective_completed.emit()
	EventBus.objective_menu_requested.emit()

func _on_bookmark_pressed() -> void:
	Globals.bookmarked_objective = objective
	EventBus.bookmarked_objective_changed.emit()
	EventBus.objective_menu_requested.emit()

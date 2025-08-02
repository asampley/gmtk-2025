extends Control

@export var max_score: float = 200
@export var max_mult: float = 5.0
@export var min_fire_aperture: float = 0.1
@onready var red_fire: TextureRect = %RedFire
@onready var blue_fire: TextureRect = %BlueFire
@onready var red_label: Label = %RedLabel
@onready var blue_label: Label = %BlueLabel

var score: float
var mult: float

func _ready() -> void:
	EventBus.combo_completed.connect(on_combo_completed)
	EventBus.combo_failed.connect(on_combo_reset)
	EventBus.combo_reset.connect(on_combo_reset)
	on_combo_reset()

func on_combo_completed(score_in: float, mult_in: float) -> void:
	score = score_in
	mult = mult_in
	var red_score_mult := score_in / max_score
	var red_aperture := clampf(3 - (3.0 * red_score_mult), min_fire_aperture, 3.0)
	red_fire.material.set("shader_paramater/fire_aperture", red_aperture)
	var blue_score_mult := (mult_in - 1) / max_mult
	var blue_aperture := clampf(3 - (3.0 * blue_score_mult), min_fire_aperture, 3.0)
	blue_fire.material.set("shader_paramater/fire_aperture", blue_aperture)
	if red_aperture >= 2.0:
		red_fire.show()
	if blue_aperture >= 2.0:
		blue_fire.show()
	update_text()

func on_combo_reset() -> void:
	score = 0
	mult = 1.0
	update_text()
	hide_flames()

func update_text() -> void:
	red_label.text = str(score)
	blue_label.text = str(mult)

func hide_flames() -> void:
	red_fire.hide()
	blue_fire.hide()

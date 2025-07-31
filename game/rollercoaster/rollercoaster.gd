class_name Rollercoaster
extends CharacterBody2D


@export var state_machine: StateMachine
@export var animations: AnimatedSprite2D
@export var path: Path2D
@export var path_follow: PathFollow2D

var stats: RollercoasterStats

func _ready() -> void:
	state_machine.initialize(self)

func _input(event: InputEvent) -> void:
	if state_machine:
		state_machine.process_input(event)

func _process(delta: float) -> void:
	if state_machine:
		state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	if state_machine:
		state_machine.process_physics(delta)


func set_stats(stats_in: RollercoasterStats) -> void:
	stats = stats_in

func set_animation(animation_name: String) -> void:
	animations.animation = animation_name



#Currently used for debugging
func set_colour(colour: Color) -> void:
	animations.modulate = colour

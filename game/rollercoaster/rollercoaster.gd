extends RigidBody2D


@export var state_machine: StateMachine
@export var animations: AnimatedSprite2D

var stats: RollercoasterStats

func _ready() -> void:
	state_machine.initialize(self)

func set_stats(stats_in: RollercoasterStats) -> void:
	stats = stats_in

func set_animation(animation_name: String) -> void:
	animations.animation = animation_name



#Currently used for debugging 
func set_colour(colour: Color) -> void:
	animations.modulate = colour

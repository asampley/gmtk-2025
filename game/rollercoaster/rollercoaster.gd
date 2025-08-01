class_name Rollercoaster
extends CharacterBody2D


@export var state_machine: StateMachine
@export var animations: AnimatedSprite2D
@export var path: Path2D
@export var path_follow: PathFollow2D
@export var deformation_limit: float = 4
@export var deformation_duration: float = 0.1

var stats: RollercoasterStats


func _ready() -> void:
	animations.animation = "flat_roll"
	state_machine.initialize(self)
	EventBus.shop_menu_closed.connect(on_shop_menu_closed)

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
	animations.play()

func deform() -> void:
	var deformation_strength: float = clamp(velocity.length(), 1, deformation_limit)
	var deformation_direction := velocity.normalized()
	var deformation_scale := deformation_direction * deformation_strength
	var tween := create_tween()
	tween.stop()
	tween.tween_property(animations.material, "shader_parameter/deformation", deformation_scale, deformation_duration)
	tween.tween_property(animations.material, "shader_parameter/deformation", Vector2.ZERO, deformation_duration * 2)
	tween.play()

func on_shop_menu_closed() -> void:
	queue_free()

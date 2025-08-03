class_name Rollercoaster
extends CharacterBody2D


@export var state_machine: StateMachine
@export var animations: AnimatedSprite2D
@export var path: Path2D
@export var path_follow: PathFollow2D
@export var deformation_limit: float = 4
@export var deformation_divider: float = 100000
@export var deformation_duration: float = 0.1
@export var camera: Camera2D
@export var particles: GPUParticles2D

@export var nitro_sound: AudioStream
@export var normal_colour: GradientTexture1D
@export var nitro_colour: GradientTexture1D


var stats: RollercoasterStats
var glide_cooldown: float = 0
var nitro_cooldown: float = 0
var nitro_remaining_duration: float = 0


func initialize() -> void:
	state_machine.initialize(self)
	camera.initialize(self)
	EventBus.shop_menu_closed.connect(on_shop_menu_closed)
	EventBus.to_the_moon.connect(on_game_win)
	EventBus.glide_cooldown_changed.emit(glide_cooldown / stats.glide_cooldown)
	EventBus.nitro_cooldown_changed.emit(nitro_cooldown / stats.nitro_cooldown)

func _input(event: InputEvent) -> void:
	if state_machine:
		state_machine.process_input(event)

func _process(delta: float) -> void:
	if state_machine:
		state_machine.process_frame(delta)

func _physics_process(delta: float) -> void:
	if glide_cooldown > 0:
		glide_cooldown -= delta
		EventBus.glide_cooldown_changed.emit(glide_cooldown / stats.glide_cooldown)
	if nitro_cooldown > 0:
		nitro_cooldown -= delta
		EventBus.nitro_cooldown_changed.emit(nitro_cooldown / stats.nitro_cooldown)
	if nitro_remaining_duration > 0:
		nitro_remaining_duration -= delta
		if nitro_remaining_duration <= 0:
			particles.process_material.color_ramp = normal_colour
			print("No more boost")
	EventBus.speed_update.emit(velocity.length())
	if state_machine:
		state_machine.process_physics(delta)

func set_stats(stats_in: RollercoasterStats) -> void:
	stats = stats_in

func set_animation(animation_name: String) -> void:
	animations.animation = animation_name
	animations.play()

func deform(direction: Vector2) -> void:
	var deformation_strength: float = clamp(velocity.length() / deformation_divider, 1, deformation_limit)
	var deformation_direction := velocity.normalized()
	var deformation_scale := deformation_direction * deformation_strength
	var tween := create_tween()
	tween.stop()
	tween.tween_property(animations.material, "shader_parameter/deformation", -deformation_scale, deformation_duration)
	tween.tween_property(animations.material, "shader_parameter/deformation", Vector2.ZERO, deformation_duration * 2)
	tween.play()

func on_shop_menu_closed() -> void:
	queue_free()

func nitro_activate() -> void:
	if nitro_cooldown <= 0:
		print("Nitro activated")
		nitro_cooldown = stats.nitro_cooldown
		nitro_remaining_duration = stats.nitro_duration
	EventBus.train_audio_requested.emit(nitro_sound)
	particles.process_material.color_ramp = nitro_colour

func nitro_active() -> bool:
	return nitro_remaining_duration > 0

# By default not applied, left up to the states
func apply_nitro(delta: float) -> void:
	if !nitro_active() || stats.nitro_acceleration <= 0.0:
		return
	velocity += velocity.normalized() * stats.nitro_acceleration * Globals.time_scale_squared * delta

func on_game_win() -> void:
	queue_free()

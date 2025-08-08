class_name RollercoasterStats


var nitro_unlocked: bool = false
var initial_velocity: float
var jump_force: float
var base_combo_multiplier: float
var combo_boost: float
var nitro_acceleration: float
var nitro_duration_seconds: float
var nitro_cooldown: float
var glide_movement_transfer: float
var glide_duration_seconds: float
var glide_cooldown: float


func initialize(rollercoaster_template: RollercoasterTemplate) -> void:
	initial_velocity = rollercoaster_template.initial_velocity
	jump_force = rollercoaster_template.jump_force
	base_combo_multiplier += rollercoaster_template.base_combo_multiplier
	combo_boost = rollercoaster_template.combo_boost
	glide_movement_transfer = rollercoaster_template.glide_movement_transfer
	glide_duration_seconds = rollercoaster_template.glide_duration_seconds
	glide_cooldown = rollercoaster_template.glide_cooldown
	nitro_duration_seconds = rollercoaster_template.nitro_duration_seconds
	nitro_cooldown = rollercoaster_template.nitro_cooldown


func apply_upgrade(upgrade: Upgrade, tier: int) -> void:
	var upgrade_tier := upgrade.template.tiers[tier]
	print("Applying upgrade %s %d: %s" % [ upgrade.template.upgrade_name, tier, upgrade_tier ])
	initial_velocity += upgrade_tier.add_initial_velocity
	jump_force += upgrade_tier.add_jump_force
	combo_boost += upgrade_tier.combo_boost
	nitro_acceleration += upgrade_tier.nitrous_acceleration
	nitro_duration_seconds += upgrade_tier.nitrous_duration_seconds
	nitro_cooldown *= upgrade_tier.nitrous_cooldown_multiplier
	glide_movement_transfer += upgrade_tier.glide_movement_transfer
	glide_duration_seconds += upgrade_tier.glide_duration_seconds
	glide_cooldown *= upgrade_tier.glide_cooldown_multiplier

	print("nitro cooldown: ", nitro_cooldown)

	if upgrade_tier.unlocks_nitro:
		nitro_unlocked = true
		EventBus.nitro_unlocked.emit()

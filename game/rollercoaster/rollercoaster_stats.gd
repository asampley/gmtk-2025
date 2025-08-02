class_name RollercoasterStats


var initial_velocity: float
var jump_force: float
var base_combo_multiplier: float
var combo_boost: float


func initialize(rollercoaster_template: RollercoasterTemplate) -> void:
	initial_velocity = rollercoaster_template.initial_velocity
	jump_force = rollercoaster_template.jump_force
	base_combo_multiplier += rollercoaster_template.base_combo_multiplier
	combo_boost = rollercoaster_template.combo_boost

func apply_upgrade(upgrade: Upgrade, tier: int) -> void:
	var upgrade_tier := upgrade.template.tiers[tier]
	initial_velocity += upgrade_tier.add_initial_velocity
	jump_force += upgrade_tier.add_jump_force
	combo_boost += upgrade_tier.combo_boost

class_name Upgrade


var upgrade_name: String
var add_initial_velocity: float
var add_jump_force: float


func initialize(template: UpgradeTemplate) -> void:
	upgrade_name = template.upgrade_name
	add_initial_velocity = template.add_initial_velocity
	add_jump_force = template.add_jump_force

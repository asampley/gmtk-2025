class_name RollercoasterStats

var initial_velocity: float
var jump_force: float


func initialize(rollercoaster_template: RollercoasterTemplate) -> void:
	initial_velocity = rollercoaster_template.initial_velocity
	jump_force = rollercoaster_template.jump_force

func apply_upgrade(upgrade: Upgrade) -> void:
	initial_velocity += upgrade.template.add_initial_velocity
	jump_force += upgrade.template.add_jump_force

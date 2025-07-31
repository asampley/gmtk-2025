class_name RollercoasterStats

var initial_velocity: float
var jump_force: float


func initialize(rollercoaster_template: RollercoasterTemplate) -> void:
	initial_velocity = rollercoaster_template.initial_velocity
	jump_force = rollercoaster_template.jump_force

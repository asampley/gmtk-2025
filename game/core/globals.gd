extends Node


enum ComboButtons { LEFT, RIGHT, UP, DOWN }
var stopped_time_until_considered_stuck: float = 5.0
var money: int = 0
var objectives: Dictionary[String, Objective] ={}
var bookmarked_objective: Objective

# If you have an acceleration (except gravity) us this factor, change gravity in the settings instead
var acceleration: float = ProjectSettings.get_setting("physics/2d/default_gravity") / 980.0

# If you have a velocity setting, use this factor
var velocity := sqrt(acceleration)

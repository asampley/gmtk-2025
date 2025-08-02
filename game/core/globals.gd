extends Node


enum ComboButtons { LEFT, RIGHT, UP, DOWN }
var stopped_time_until_considered_stuck: float = 5.0
var money: int = 0
var objectives: Dictionary[String, Objective] ={}
var bookmarked_objective: Objective

# If you have an time_scale_squared (except gravity) us this factor, change gravity in the settings instead
var time_scale_squared: float = ProjectSettings.get_setting("physics/2d/default_gravity") / 980.0

# If you have a time_scale setting, use this factor
var time_scale := sqrt(time_scale_squared)

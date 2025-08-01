class_name ComboTemplate
extends Resource


enum ComboButtons { LEFT, RIGHT, UP, DOWN }

@export var combo_name: String
@export var sequence: Array[ComboButtons]
@export var animation_name: String
@export var deforming_strength: float

extends PathFollow2D

@export var period: float

func _process(delta: float) -> void:
	self.progress_ratio += delta / period

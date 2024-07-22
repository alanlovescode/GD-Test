extends Sprite2D

@export var lifetime := 0.5

@onready var _tween := $Tween


func _ready() -> void:
	fade()


func fade(duration := lifetime) -> void:
	var transparent := self_modulate
	transparent.a = 0.0
	_tween.interpolate_property(self, "self_modulate", self_modulate, transparent, duration)
	_tween.start()
	await _tween.tween_all_completed
	queue_free()

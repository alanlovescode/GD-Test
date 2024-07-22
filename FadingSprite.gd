extends Sprite2D

@export var lifetime:=0.5




func _ready() -> void:
	fade(lifetime)





func fade(duration:float)->void:
	var transparent:=modulate
	transparent.a=0
	
	var tween=create_tween()
	tween.tween_property(self, "modulate", transparent, duration)
	await tween.finished
	queue_free()

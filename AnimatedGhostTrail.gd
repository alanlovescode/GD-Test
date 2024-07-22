extends Sprite2D


var fadingSprite=preload("res://fading_sprite.tscn")

@export var amount:int
@export var isEmitting:bool
@onready var ghost_spawn_timer: Timer = %GhostSpawnTimer


func SetIsEmitting(value:bool)->void:
	if isEmitting:
		SpawnGhost()
		ghost_spawn_timer.start(1/amount)
	else:
		ghost_spawn_timer.stop()



func SpawnGhost()->void:
	var ghost=fadingSprite.instantiate()
	ghost.texture=texture
	ghost.offset=offset
	ghost.flip_h=flip_h
	ghost.flip_v=flip_v
	ghost.global_position=global_position
	
	add_child(ghost)
	ghost.set_as_top_level(true)

func _on_ghost_spawn_timer_timeout() -> void:
	SpawnGhost()

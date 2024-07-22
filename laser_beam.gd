class_name LaserBeam

extends RayCast2D



@export var maxLength:=1400.0
@export var castSpeed:=5000
@export var growthTime:float=0.1

@onready var fillLine: Line2D = %FillLine
@onready var lineWidth:float=fillLine.width
@onready var casting_praticles: GPUParticles2D = %CastingPraticles
@onready var beam_particles: GPUParticles2D = %BeamParticles
@onready var collision_particles: GPUParticles2D = %CollisionParticles




var castTo:Vector2=Vector2.ZERO

var isCasting:bool=false: set = IsCasting


func _ready() -> void:
	set_physics_process(false)
	fillLine.points[1]=Vector2.ZERO
	enabled=true
	
	
	

func _physics_process(delta: float) -> void:
	castTo+=(Vector2.RIGHT*castSpeed*delta).limit_length(maxLength)
	CastBeam()
	print(isCasting)




func CastBeam()->void:
	var castPoint:=castTo
	force_raycast_update()
	collision_particles.emitting=is_colliding()
	if is_colliding():
		castPoint=to_local(get_collision_point())
		collision_particles.global_rotation=get_collision_normal().angle()
		collision_particles.position=castPoint
	fillLine.points[1]=castPoint
	beam_particles.position=castPoint*0.5
	beam_particles.process_material.emission_box_extents.x=castPoint.length()*0.5


func IsCasting(cast:bool)->void:
	isCasting=cast
	if isCasting:
		castTo=Vector2.ZERO
		fillLine.points[1]=castTo
		Appear()
	else:
		collision_particles.emitting=false
		Disappear()
	
	set_physics_process(isCasting)
	casting_praticles.emitting=isCasting
	beam_particles.emitting=isCasting


func Appear()->void:
	var tween=create_tween()
	if !tween.finished:
		tween.stop()
	tween.tween_property(fillLine, "width", lineWidth, growthTime*2)


func Disappear()->void:
	var tween=create_tween()
	if !tween.finished:
		tween.stop()
	tween.tween_property(fillLine, "width", 0, growthTime)


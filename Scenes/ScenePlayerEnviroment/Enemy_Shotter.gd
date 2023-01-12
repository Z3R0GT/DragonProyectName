extends CharacterBody3D

var maxHp : float = 20
var curHp : float = 20
var attackRange : float = 3.0

@export var TimeRecoil : float = 5.0
@export var move : float = 5.0
var FireBall = 5

var target

@onready var ball = preload("res://Scenes/Redundants/fire_chock.tscn")

@onready var time = $TimeRecoil
@onready var TimeShot = $TimeShot


@onready var Healt = $HealtBar
@onready var reach_ray = $RayCast3D
@onready var pivot = $pivote

func take_damage(damage):
	curHp -= damage
	
	if curHp <= 0:
		die()
func die():
	queue_free()

func _ready():

	time.wait_time = TimeRecoil

func _process(delta: float) -> void:
	Healt.value = curHp
	Healt.max_value = maxHp

func _physics_process(delta):
	_check_reaching_player()
	_move_towards_target(delta)

func _check_reaching_player():
	if not reach_ray.is_colliding():
		#Reemplazar con rutas
		return
	
	var body = reach_ray.get_collider()
	if not body:
		return
	
	if body.is_in_group("player"):
		target = body

func _move_towards_target(delta):
	if not target:
		return
	
	var target_pos = target.global_transform.origin
	
	var dir = position.direction_to(target_pos)
	if reach_ray.is_colliding():
		velocity = Vector3.ZERO 
		if reach_ray.get_collider().is_in_group("enemi"):
			look_at(Vector3(0,0,0), Vector3.UP)
		else:
			shot(target.global_transform)
	else:
			velocity = dir * move 
	look_at(target_pos, Vector3.UP)
	move_and_slide()

var can_shot = true
func shot(target):
	if can_shot == true:
		if FireBall > 0:
			Recoil()
			var bullet = ball.instantiate()
			get_tree().get_root().add_child(bullet)
			bullet.global_transform = target
			FireBall -= 1
			TimeShot.start()
			can_shot = false
		else:
			Recoil()

func Recoil():
	time.start()

func _on_timer_timeout():
	FireBall = 5
	time.stop()
	time.wait_time = TimeRecoil
	

func _on_time_shot_timeout():
	can_shot = true
	TimeShot.stop()
	TimeShot.wait_time = 5

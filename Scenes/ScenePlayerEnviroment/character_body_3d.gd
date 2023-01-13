extends CharacterBody3D

const JUMP_VELOCITY = 4.5

#Gravedad por default del motor
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


var maxHp = 50
var curHp = 50
var damage : int = 1

#var gold : int = 0 //tiene que introducir objetivos
var attackRate : float = .3
var lastAttackTime : float = 0

@export_category("Valores Generales")
@export var moveSpeed : float = 2
@export var TimeRecoil : float = 30.0
@export var FireBall : int = 0

@onready var Instance = $Pivote/Camera3D/Ball
@onready var camera = $Pivote
@onready var attackCast = $RayCast3D
@onready var Animacion = $dragon_withAnimations/AnimationPlayer
@onready var ui = $UI/Control

@onready var ball = preload("res://Scenes/Redundants/fire_chock.tscn")
@onready var time = $Timer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	time.wait_time = TimeRecoil
	write("res://Assets/stats.txt", str(FireBall))
	
	ui.update_health_bar(curHp, maxHp)
	ui.update_fireBall_text(FireBall)

var try = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shot"):
		try_attack()
	
	if Input.is_action_just_pressed("changed_person"):
		try += 1
		if try == 1:
			anima.play("Changed_1ts")
		print(try)

func try_attack():
	if Time.get_ticks_msec() - lastAttackTime < attackRate * 1000:
		return
	
	lastAttackTime = Time.get_ticks_msec()
	
	if attackCast.is_colliding():
		if attackCast.get_collider().has_method("take_damage"):
			print("animación.stop")
			print("animación.play(atacar)")
			attackCast.get_collider().take_damage(damage)
	else:
		Shot()

func Shot():
	if FireBall > 0:
		Recoil()
		var bullet = ball.instantiate()
		get_tree().get_root().add_child(bullet)
		bullet.global_transform = Instance.global_transform
		FireBall -= 1
		ui.update_fireBall_text(FireBall)
	else:
		Recoil()

func Recoil():
	time.start()

@onready var anima = $Pivote/AnimationPlayer

func _physics_process(delta: float) -> void:
	var ver = false
	
	if try == 2:
		try = 0
		ver = false
		anima.play("Changed_3rd")
		$Pivote/Animation.start(3)
	elif try == 1:
		$Pivote/Animation.start(3)
		ver = true
		
	if ver:
		var input_dir = Input.get_vector("left", "right", "forward", "back")
		var direction = (camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * moveSpeed
			velocity.z = direction.z * moveSpeed
		else:
			velocity.x = move_toward(velocity.x, 0, moveSpeed)
			velocity.z = move_toward(velocity.z, 0, moveSpeed)
		move_and_slide()
	elif ver == false:
		$dragon_withAnimations.visible = true
		var input_dir = Input.get_vector("Right", "left", "back", "Foward")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * moveSpeed
			velocity.z = direction.z * moveSpeed
			
			#llama "animationPlayer" y reproduce la animacion de correr pero hacia atras
			if is_on_floor():
				if Input.is_action_just_pressed("back"):
					
					Animacion.play_backwards("running")
				else:
					Animacion.play("running")
		else:
			Animacion.play("idle")
			velocity.x = move_toward(velocity.x, 0, moveSpeed)
			velocity.z = move_toward(velocity.z, 0, moveSpeed)
		
		if not is_on_floor():
			velocity.y -= gravity * delta
			#Animacion.play("flying")
			
			$dragon_withAnimations/RootNode0.position.y = -0.369
		elif is_on_floor():
			$dragon_withAnimations/RootNode0.position.y = 0
		
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			#$dragon_withAnimations/RootNode0.position.y = -0.369
			#Animacion.play("flying")
		move_and_slide()
	
func take_damage(damage):
	curHp -= damage
	ui.update_health_bar(curHp, maxHp)
	print(curHp)
	if curHp <= 0:
		die()

func die():
	get_tree().reload_current_scene()


func write(dir, data):
	var file = FileAccess.open(dir, FileAccess.WRITE)
	file.store_string(data)
	file = null
func read(dir):
	var file = FileAccess.open(dir, FileAccess.READ)
	if not file.file_exists(dir):
		return null
	var data = file.get_as_text()
	file = null
	return data

func get_save_stats():
	return{
		'filename' : get_name(),
		'parent' : get_parent().get_path(),
		'x_pos' : position.x,
		'y_pos' : position.y,
		'z_pos' : position.z,
		
		'stats' : {
			'life' : curHp,
			'fireball' : int(read("res://Assets/stats.txt"))
			}
	}
func load_save_stats(stats):
	position = Vector3(stats.x_pos, stats.y_pos, stats.z_pos)
	curHp = stats.stats.life
	write("res://Assets/stats.txt", str(stats.stats.fireball))

func _on_timer_timeout():
	FireBall = int(read("res://Assets/stats.txt"))
	ui.update_fireBall_text(FireBall)
	time.stop()
	time.wait_time = TimeRecoil


func _on_animation_timeout():
	if try == 1:
		$dragon_withAnimations.visible = false
	


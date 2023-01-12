extends Node3D

@export_category("Objetivos")
@export_node_path(Node3D) var Target
@export_node_path(CharacterBody3D) var player

@export_category("Tiempo de espera")
@export var Espera : int = 5
@export var TempEspera : int = 4
var maxTime = Espera


@onready var TempDead = $TempDead
@onready var Life = $lifeTime
@onready var helt = $UI/Control
@onready var time = $Timer


@onready var PosTP = get_node(player)
@onready var Pos = get_node(Target)

var ver = false
var veCount = false

@onready var Portal = $MagicPortal/AnimationPlayer

func _ready():
	Portal.play("Scene")
	$audio.stream.loop = false
	time.wait_time = Espera

func _process(delta: float) -> void:
	var posTarget = Vector3(Pos.position.x, 0, Pos.position.z)
	
	helt.update_helt(maxTime, time.time_left)
	
	if ver and veCount:
		instanciar(posTarget)


var particle = WorldSettings.SubPortal.instantiate()

func instanciar(posTarget): 
	
	if WorldSettings.can_particle_show:
		get_parent().add_child(particle)
		
		#Posición
		particle.global_transform = Pos.global_transform
	else:
		particle.visible = true
	
	#posición de jugador
	PosTP.position = posTarget
	TempDead.position = posTarget
	
	#Instancia Temporal
	tempIns()
	
	#UI
	helt.visible = false
	veCount = false
	ver = false
	
	
func _on_area_3d_body_entered(body):
	
	if body.is_in_group("player"):
		#Accion si el jugador entra
		Portal.play("Scene")
		helt.visible = true
		ver = true
		time.start()
		$audio.play()
		helt.update_helt(maxTime, time.time_left)

func tempIns():
	#Tiempo de vida
	Life.wait_time = TempEspera
	Life.start()
	
	#Audio
	TempDead.stream.loop = false
	TempDead.play()

func _on_timer_timeout():
	veCount = true
	time.stop()
	time.wait_time = Espera

func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		time.stop()
		time.wait_time = Espera
		helt.visible = false

func _on_life_time_timeout():
	WorldSettings.can_particle_show = false
	
	particle.visible = false
	
	Life.wait_time = TempEspera
	Life.stop()

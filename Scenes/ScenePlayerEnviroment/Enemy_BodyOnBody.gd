extends CharacterBody3D

@export_category("Estadisticas")
@export var curHp : int = 10
@export var maxHp :int = 10
@export var damage : int = 5
@export var moveSpeed : float = 5


var seeDist : float = 2
var attackRate : float = 2.0

var target
@onready var attackCast = $RayCast3D
@onready var Healt = $HealtBar
@onready var timer = $Timer
@onready var player = get_tree().get_nodes_in_group("player")[0]


func _ready() -> void:
	timer.wait_time = attackRate
	timer.start()

func _process(delta: float) -> void:
	Healt.value = curHp
	Healt.max_value = maxHp
	


func _physics_process(delta: float) -> void:
	var dist = position.direction_to(player.position)
	
	if dist.z < seeDist or dist.x < seeDist:
		velocity.z = dist.z * moveSpeed 
		velocity.y = 0
		velocity.x = dist.x * moveSpeed 
		look_at(player.position)
		$MeshInstance3D/AnimationPlayer.play("walk")
		move_and_slide()

func take_damage(damage):
	curHp -= damage
	if curHp <= 0:
		die()
	
func die():
	queue_free()

func _on_timer_timeout() -> void:
	
	if attackCast.is_colliding():
		$MeshInstance3D/AnimationPlayer.stop()
		$MeshInstance3D/AnimationPlayer.play("attack")
		if attackCast.get_collider().is_in_group("player"):
			attackCast.get_collider().take_damage(damage)



extends Area3D

var attackDist :float = 1.5
var speed : float = 20.0
var damage : int = 5

@onready var enemi = get_tree().get_nodes_in_group("enemi")

func _process(delta: float) -> void:
	position += global_transform.basis.z * speed * delta
	
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()

func _on_timer_timeout():
	queue_free()


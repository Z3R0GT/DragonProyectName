extends Camera3D

@export_node_path var target
@onready var player = get_node(target)

func _process(delta):
	position = Vector3(player.position.x, 30, player.position.z)

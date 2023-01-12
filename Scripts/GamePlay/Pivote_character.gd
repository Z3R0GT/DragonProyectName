extends Node3D

var lookSensitivity : float = .5
var minLookAngle : float = -10.0
var maxLookAngle : float = 30.0

var mouseDelta = Vector2()

@onready var player = get_parent()

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

func _process(delta: float) -> void:
	
	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
	
	rotation.x += rot.x
	rotation.x = clamp(rotation.x, deg_to_rad(minLookAngle), deg_to_rad(maxLookAngle))
	
	player.rotation.y -= rot.y
	
	mouseDelta = Vector2()

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

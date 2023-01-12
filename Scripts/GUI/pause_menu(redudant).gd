extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Button.grab_focus()

func _process(delta):
	pass


func _on_button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	visible = false


func _on_button_2_pressed():
	pass # Replace with function body.


func _on_button_3_pressed():
	queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
	visible = false
	WorldSettings.can_menu_show = true
	

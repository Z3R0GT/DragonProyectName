extends Node3D


func _ready():
	$CanvasLayer/SubMenuStart/VBoxContainer/start.grab_focus()

func _on_start_pressed():
	var World = WorldSettings.WorldGeneralEnviroment.instantiate()
	WorldSettings.can_menu_show = false
	get_parent().add_child(World)
	queue_free()

func _on_config_pressed():
	var set = WorldSettings.setting.instantiate()
	WorldSettings.can_setting_show = true
	add_child(set)
	
func _on_credits_pressed():
	pass #  crea un popput de creaditos


func _on_exit_pressed():
	get_tree().quit()


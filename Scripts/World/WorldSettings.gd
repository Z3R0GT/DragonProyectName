extends Node

signal fps_display(value)

var can_level_show = false
var can_menu_show = true
var can_setting_show = false
var can_particle_show = true

@onready var WorldGeneralEnviroment = preload("res://Scenes/Enviroments/world_enviroment_principal.tscn")
@onready var SubMenu = preload("res://Scenes/Menus/SubMenu(Start).tscn") 
@onready var setting = preload("res://Scenes/Redundants/settings_menu.tscn")
@onready var SubPortal = preload("res://Scenes/Redundants/effects/invocation.tscn")



func toggle_fps_display(value):
	emit_signal("fps_display", value)


func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)

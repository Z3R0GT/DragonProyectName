extends Control

#configuración de  video
@onready var fps_display = $ColorRect/TabContainer/Video/MarginContainer/Video/CheckButton

#condiguración de audio
@onready var Master_volum = $ColorRect/TabContainer/Volumen/MarginContainer/Video/MasterVol
@onready var Music_volum = $ColorRect/TabContainer/Volumen/MarginContainer/Video/MusicVol
@onready var varSFX_volum = $ColorRect/TabContainer/Volumen/MarginContainer/Video/SFXVol

func _process(_delta):
	
	if WorldSettings.can_setting_show == true:
		visible = true

func _on_check_button_pressed():
	pass # Replace with function body.

func _on_master_vol_value_changed(value):
	WorldSettings.update_master_vol(value)


func _on_music_vol_value_changed(value):
	pass # Replace with function body.


func _on_sfx_vol_value_changed(value):
	pass # Replace with function body.


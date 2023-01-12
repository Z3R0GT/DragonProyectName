extends Node3D

@onready var puase = $UI/PauseMenu

func _process(delta):
	
	ignore_this()
	
	if WorldSettings.can_menu_show:
		
		var men = WorldSettings.SubMenu.instantiate()
		get_parent().add_child(men)
		queue_free()

func _physics_process(delta):
	
	if Input.is_action_just_pressed("esc"):
		puase.visible = true
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


#esta función solo sirve para llamar animaciones redundantes 
func ignore_this():
	#objetos de obtención
	$Objects/Takes/dark_hole/AnimationPlayer.play("Scene")
	
	#Portales
	$Objects/Portals/stargate/AnimationPlayer.play("Take 001")
	$Objects/Portals/islandGate/AnimationPlayer.play("Take 001")
	$Objects/Portals/demonic_gateway_with_animated_orbs/AnimationPlayer.play("Take 001")
	
	#Objetos
	$Objects/Structures/StaticBody3D/greek_temple/Sketchfab_model/root/GLTF_SceneRootNode/Suzanne_2/Object_37.visible = false
	$Objects/Structures/StaticBody3D/greek_temple/Sketchfab_model/root/GLTF_SceneRootNode/Suzanne_2/Object_38.visible = false
	$Objects/Structures/StaticBody3D/greek_temple/Sketchfab_model/root/GLTF_SceneRootNode/Suzanne_2/Object_39.visible = false
	$Objects/Structures/StaticBody3D/greek_temple/Sketchfab_model/root/GLTF_SceneRootNode/Suzanne_2/Object_40.visible = false
	
	
	

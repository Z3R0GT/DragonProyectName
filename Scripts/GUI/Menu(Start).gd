extends Node

func _ready():
	
	if WorldSettings.can_menu_show == true:
		var menus = WorldSettings.SubMenu.instantiate()
		add_child(menus)
		
		WorldSettings.can_menu_show = false

extends Node

var save_filename = "user://save_game.save"

func save_game():
	
	var save_file = FileAccess.open(save_filename, FileAccess.WRITE)
	
	var saved_nodes = get_tree().get_nodes_in_group("Saved")
	
	for node in saved_nodes:
		
		var node_details = node.get_save_stats()
		save_file.store_line(JSON.stringify(node_details))
	
	save_file = null

func load_game():
	var save_file = FileAccess.new()
	
	if not save_file.file_exists(save_filename):
		return
	
	var saved_nodes = get_tree().get_nodes_in_group("Saved")
	
	for node in saved_nodes:
		node.queue_free()
	
	save_file.open(save_filename, FileAccess.READ)
	
	
	while save_file.get_position() < save_file.get_length():
		var node_data = JSON.parse_string(save_file.get_line())
		var new_obj = load(node_data.filename).instantiate()
		
		get_node(node_data.parent).call_deferred('add_child', new_obj)
		new_obj.load_save_stats(node_data)

func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		save_game()










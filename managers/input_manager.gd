extends Node

export (NodePath) var viewport_manager_path


func _ready():
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")
	_initialize_joy_connections()


func _initialize_joy_connections():
	for joy_id in Input.get_connected_joypads():
		_joy_connection_changed(joy_id, true)


func _joy_connection_changed(id: int, status: bool):
	if status:
		# Create a player input controller and add it
		# Create a new node object, load the script
		var player_controller = Node.new()
		var player_input_manager_script = load("res://managers/player_input_manager.gd")
		# Add the script to the node, do the setup and set the name
		player_controller.set_script(player_input_manager_script)
		player_controller.setup(viewport_manager_path, id)
		player_controller.set_name("PlayerController-" + str(id))
		# Instantiate the node
		add_child(player_controller)
	elif ! status:
		# Remove the existing player input controller
		remove_child(self.get_node("PlayerController-" + str(id)))

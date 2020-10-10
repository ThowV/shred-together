extends Node

const JB = preload("res://scripts/enums/JoyButton.gd")
const JIP = preload("res://scripts/enums/JoyInputType.gd")

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
		var player_controller 			= Node.new()
		var player_controller_script	= load("res://scripts/PlayerInputManager.gd")
		# Add the script to the node, do the setup and set the name
		player_controller.set_script(player_controller_script)
		player_controller.setup(self, id)
		player_controller.set_name("PlayerController-" + str(id))
		# Instantiate the node
		add_child(player_controller)
	elif !status:
		# Remove the existing player input controller
		remove_child(self.get_node("PlayerController-" + str(id)))
		
func input_made(joy_id: int, button_type, input_type, value):
	print("Controller %s made input using %s with type %s with value %s" % [joy_id, JB.JoyButton.keys()[button_type], JIP.JoyInputType.keys()[input_type], value])
	#Input.start_joy_vibration(joy_id, 0.1, 0.2, 1)

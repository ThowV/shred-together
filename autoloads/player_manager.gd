extends Node

export (Resource) var joycon_play_input_manager_path
export (Resource) var joycon_ui_input_manager_path

var players = []

onready var state_manager = get_node("/root/StateManager")
onready var viewport_manager = get_node("/root/ViewportManager")


func _ready():
	state_manager.connect("state_switched", self, "_create_ims")
	# warning-ignore:return_value_discarded
	Input.connect("joy_connection_changed", self, "_joy_connection_changed")

	_initialize_joy_connections()


func _initialize_joy_connections():
	for joy_id in Input.get_connected_joypads():
		_joy_connection_changed(joy_id, true)


func _joy_connection_changed(id: int, status: bool):
	if status:
		players.append({joycon_id = id, character_id = id})  # BOTH TEMPORARY SET TO ID
	elif ! status:
		players.erase(id)


# warning-ignore:unused_argument
func _create_ims(state_prev, state_curr):
	for player in players:
		# Create a new node and load the script
		var player_controller = Node.new()
		var player_input_manager_script

		if state_curr == state_manager.STATE.PLAY:
			player_input_manager_script = joycon_play_input_manager_path
		elif state_curr == state_manager.STATE.UI:
			player_input_manager_script = joycon_play_input_manager_path

		# Add the script to the node, do the setup and set the name
		player_controller.set_script(player_input_manager_script)
		player_controller.setup(viewport_manager.characters[player.character_id], player.joycon_id)
		player_controller.set_name(
			"JoyconIM-%s-%s" % [player.joycon_id, state_manager.STATE.keys()[state_curr]]
		)

		# Instantiate the node
		add_child(player_controller)


func _destroy_ims():
	for i in range(get_child_count()):
		get_child(i).queue_free()

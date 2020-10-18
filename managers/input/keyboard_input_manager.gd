extends Node

var state = "play"
var use_input_map: bool
var button_pressed_state = []

onready var global = get_node("/root/Global")

signal button_performed(perform_type, input_type, button_id)


# warning-ignore:shadowed_variable
func setup(use_input_map: bool):
	self.use_input_map = use_input_map
	button_pressed_state.resize(16)


func _process(_delta: float):
	# Check for keyboard buttons
	pass


func _physics_process(_delta: float):
	if state == "play":
		if Input.action_press("play_forward"):
			pass


func _emit_input(perform_type: String, button_id: int):
	if ! use_input_map or (use_input_map and global.JOYCON_INPUT_MAP.has("JOY_%s" % button_id)):
		emit_signal("button_performed", perform_type, "JOY", button_id)


# warning-ignore:shadowed_variable
func set_use_input_map(use_input_map: bool):
	self.use_input_map = use_input_map

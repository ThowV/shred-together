extends Node

var joy_id: int
var use_input_map: bool
var button_pressed_state = []

onready var global = get_node("/root/Global")


# warning-ignore:shadowed_variable
func setup(joy_id: int, use_input_map: bool):
	self.joy_id = joy_id
	self.use_input_map = use_input_map
	button_pressed_state.resize(16)


func _process(_delta: float):
	# Check for joy buttons
	for btn_idx in range(len(button_pressed_state)):
		if Input.is_joy_button_pressed(joy_id, btn_idx) and ! button_pressed_state[btn_idx]:
			button_pressed_state[btn_idx] = true
			#_emit_input("PRESSED", btn_idx)
		elif ! Input.is_joy_button_pressed(joy_id, btn_idx) and button_pressed_state[btn_idx]:
			button_pressed_state[btn_idx] = false
			#_emit_input("RELEASED", btn_idx)


func _emit_input(perform_type: String, button_id: int):
	if ! use_input_map or (use_input_map and global.JOYCON_INPUT_MAP.has("JOY_%s" % button_id)):
		pass  #emit_signal("button_performed", perform_type, "JOY", button_id)


# warning-ignore:shadowed_variable
func set_use_input_map(use_input_map: bool):
	self.use_input_map = use_input_map

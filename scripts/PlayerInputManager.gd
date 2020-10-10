extends Node

const JB = preload("res://scripts/enums/JoyButton.gd")
const JIP = preload("res://scripts/enums/JoyInputType.gd")
const DEADZONE = 0.5

var input_manager: Node
var joy_id: int
var jump_pressed: bool

# warning-ignore:shadowed_variable
func setup(input_manager: Node, joy_id: int):
	self.input_manager = input_manager
	self.joy_id = joy_id
	
func _physics_process(_delta: float):
	# Check for buttons
	if Input.is_joy_button_pressed(joy_id, 0) and !jump_pressed:
		# Jump got pressed for the first time
		jump_pressed = true
		input_manager.input_made(joy_id, JB.JoyButton.T1, JIP.JoyInputType.PRESS_START, 1)
	if !Input.is_joy_button_pressed(joy_id, 0) and jump_pressed:
		# Jump got released
		jump_pressed = false
		input_manager.input_made(joy_id, JB.JoyButton.T1, JIP.JoyInputType.PRESS_RELEASE, 1)
	
	# Check for sticks
	var left_stick_raw_input = Vector2(
		Input.get_joy_axis(joy_id, 0),
		Input.get_joy_axis(joy_id, 1)
	)
	var left_stick_input = Vector2(0, 0)
	
	var rigt_stick_raw_input = Vector2(
		Input.get_joy_axis(joy_id, 2),
		Input.get_joy_axis(joy_id, 3)
	)
	var right_stick_input = Vector2(0, 0)
	
	# Filter joy sticks using deadzone
	# Filter left stick horizontal input
	if left_stick_raw_input.x >= DEADZONE or left_stick_raw_input.x <= -DEADZONE:
		left_stick_input.x = left_stick_raw_input.x
	# Filter left stick vertical input
	if left_stick_raw_input.y >= DEADZONE or left_stick_raw_input.y <= -DEADZONE:
		left_stick_input.y = left_stick_raw_input.y
	# Filter right stick horizontal input
	if rigt_stick_raw_input.x >= DEADZONE or rigt_stick_raw_input.x <= -DEADZONE:
		right_stick_input.x = rigt_stick_raw_input.x
	# Filter right stick vertical input
	if rigt_stick_raw_input.y >= DEADZONE or rigt_stick_raw_input.y <= -DEADZONE:
		right_stick_input.y = rigt_stick_raw_input.y
	
	# Send the inputs to the global input manager
	# Send left stick input
	if left_stick_input.length() > 0:
		input_manager.input_made(joy_id, JB.JoyButton.T1, JIP.JoyInputType.PIVOT, left_stick_input)
	# Send right stick input
	if right_stick_input.length() > 0:
		input_manager.input_made(joy_id, JB.JoyButton.T1, JIP.JoyInputType.PIVOT, right_stick_input)

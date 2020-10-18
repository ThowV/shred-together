extends Node

var character: Node
var joy_id: int
var jump_pressed: bool
var button_pressed_state = []

onready var global = get_node("/root/Global")


# warning-ignore:shadowed_variable
func setup(character: Node, joy_id: int):
	self.character = character
	self.joy_id = joy_id
	button_pressed_state.resize(16)


func _process(_delta: float):
	handle_buttons()


func _physics_process(delta: float):
	handle_movement(delta)


func handle_buttons():
	var jump_btn_id = global.joycon_map_to_id("JUMP")
	if Input.is_joy_button_pressed(joy_id, jump_btn_id):
		pass


func handle_movement(delta: float):
	character.do_movement(delta, get_stick_input(0, 1))


func handle_rotation():
	pass  #character.do_rotation(get_stick_input(2, 3))


func get_stick_input(x_axis: int, y_axis: int) -> Vector2:
	# Check for sticks
	var stick_raw_input = Vector2(
		Input.get_joy_axis(joy_id, x_axis), Input.get_joy_axis(joy_id, y_axis)
	)
	var stick_input = Vector2(0, 0)

	# Apply deadzone to left stick horizontal movement and send input
	if stick_raw_input.x >= global.JOYCON_DEADZONE or stick_raw_input.x <= -global.JOYCON_DEADZONE:
		stick_input.x = sign(stick_raw_input.x)
	# Apply deadzone to left stick vertical movement and send input
	if stick_raw_input.y >= global.JOYCON_DEADZONE or stick_raw_input.y <= -global.JOYCON_DEADZONE:
		stick_input.y = sign(stick_raw_input.y)

	return stick_input

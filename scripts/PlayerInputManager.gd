extends Node

const DEADZONE = 0.5

var character: Node
var joy_id: int
var jump_pressed: bool


# warning-ignore:shadowed_variable
func setup(character: Node, joy_id: int):
	self.character = character
	self.joy_id = joy_id


func _physics_process(delta: float):
	handle_movement(delta)

	# Check for buttons
	if Input.is_joy_button_pressed(joy_id, 0) and ! jump_pressed:
		# Button 0 got pressed for the first time
		jump_pressed = true
	if ! Input.is_joy_button_pressed(joy_id, 0) and jump_pressed:
		# Button 0 got released
		jump_pressed = false


func handle_movement(delta: float):
	character.do_movement(delta, get_stick_input(0, 1))


func handle_rotation():
	#character.do_rotation(get_stick_input(2, 3))
	pass


func get_stick_input(x_axis: int, y_axis: int) -> Vector2:
	# Check for sticks
	var stick_raw_input = Vector2(
		Input.get_joy_axis(joy_id, x_axis), Input.get_joy_axis(joy_id, y_axis)
	)
	var stick_input = Vector2(0, 0)

	# Apply deadzone to left stick horizontal movement and send input
	if stick_raw_input.x >= DEADZONE or stick_raw_input.x <= -DEADZONE:
		stick_input.x = sign(stick_raw_input.x)
	# Apply deadzone to left stick vertical movement and send input
	if stick_raw_input.y >= DEADZONE or stick_raw_input.y <= -DEADZONE:
		stick_input.y = sign(stick_raw_input.y)

	return stick_input

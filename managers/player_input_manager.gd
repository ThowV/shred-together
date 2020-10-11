extends Node

const DEADZONE = 0.5

var playing: bool
var character: Node
var viewport_manager_path: NodePath
var joy_id: int
var jump_pressed: bool


# warning-ignore:shadowed_variable
func setup(viewport_manager_path: NodePath, joy_id: int):
	self.playing = false
	self.viewport_manager_path = viewport_manager_path
	self.joy_id = joy_id


func _physics_process(delta: float):
	# Check for buttons
	if Input.is_joy_button_pressed(joy_id, 0) and ! jump_pressed:
		# Button 0 got pressed for the first time
		jump_pressed = true
		# Enter playing state
		if ! playing:
			character = get_parent().get_node(viewport_manager_path).spawn_character(joy_id)
			playing = true
	if ! Input.is_joy_button_pressed(joy_id, 0) and jump_pressed:
		# Button 0 got released
		jump_pressed = false

	if playing:
		handle_movement(delta)


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

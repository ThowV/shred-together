extends KinematicBody

const GRAVITY = -260
const SPEED_MAX = 7
const SPEED_SLOWDOWN = 0.2
const MOUSE_SENSITIVITY = 2 * 0.001  # Sens * radians per pixel

onready var camera_pivot = $CameraPivot
onready var camera = $CameraPivot/Camera

var velocity = Vector3()


func _physics_process(delta):
	do_gravity(delta)


func do_gravity(delta: float):
	# Apply gravity to the velocity
	velocity.y += GRAVITY * delta
	move_and_slide(velocity, Vector3.UP, true)


func do_movement(delta: float, input: Vector2):
	# Detmine the input direction based on camera rotation
	var input_direction = Vector3()
	input_direction += input.x * camera.global_transform.basis.x
	input_direction += input.y * camera.global_transform.basis.z
	input_direction = input_direction.normalized()

	# Determine the velocity and apply it
	velocity = input_direction * SPEED_MAX
	move_and_slide(velocity, Vector3.UP, true)

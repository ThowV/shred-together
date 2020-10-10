extends KinematicBody

var velocity = Vector3(0, 0, 0)
var slowdown_speed = 0.2
const TOP_SPEED = 7

func _ready():
	pass

func _physics_process(_delta: float):
	if Input.is_action_pressed("play_left") and Input.is_action_pressed("play_right"):
		velocity.x = lerp(velocity.x, 0, slowdown_speed)
	elif Input.is_action_pressed("play_left"):
		velocity.x = -TOP_SPEED
	elif Input.is_action_pressed("play_right"):
		velocity.x = TOP_SPEED
	else:
		velocity.x = lerp(velocity.x, 0, slowdown_speed)
	
	if Input.is_action_pressed("play_forwards") and Input.is_action_pressed("play_backwards"):
		velocity.x = lerp(velocity.z, 0, slowdown_speed)
	elif Input.is_action_pressed("play_forwards"):
		velocity.z = -TOP_SPEED
	elif Input.is_action_pressed("play_backwards"):
		velocity.z = TOP_SPEED
	else:
		velocity.z = lerp(velocity.z, 0, slowdown_speed)
		
	move_and_slide(velocity)
	
func do_input(button_type: JoyButton, input_type: JoyInputType, value: Object):
	pass

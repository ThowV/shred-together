extends Node

func _physics_process(delta):
	for i in Input.get_connected_joypads():
		print("Device " + str(i))
	
	if Input.is_action_pressed("play_left") and Input.is_action_pressed("play_right"):
		print("stop")
	elif Input.is_action_pressed("play_left"):
		print("left")
	elif Input.is_action_pressed("play_right"):
		print("right")
	else:
		print("stop")
	
	if Input.is_action_pressed("play_forwards") and Input.is_action_pressed("play_backwards"):
		print("stop")
	elif Input.is_action_pressed("play_forwards"):
		print("forwards")
	elif Input.is_action_pressed("play_backwards"):
		print("backwards")
	else:
		print("stop")

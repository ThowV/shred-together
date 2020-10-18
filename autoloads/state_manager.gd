extends Node

enum STATE { UI, LOAD, PLAY }

var state_curr = STATE.UI

signal state_switched(state_prev, state_curr)


func temp_switch():
	var state_prev = state_curr
	state_curr = STATE.PLAY
	emit_signal("state_switched", state_prev, state_curr)

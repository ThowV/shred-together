extends Node

enum JoyInputType { AXIS, BUTTON }

enum JoyInputAction {
	PRESS_START,
	PRESSING,
	PRESS_RELEASE,
	PIVOT,
}

enum PlayerActions { MOVE_HORIZONTAL, MOVE_VERTICAL, LOOK_HORIZONTAL, LOOK_VERTICAL, JUMP }

const PLAYER_INPUT_MAP_AXIS = [
	PlayerActions.MOVE_HORIZONTAL,
	PlayerActions.MOVE_VERTICAL,
	PlayerActions.LOOK_HORIZONTAL,
	PlayerActions.LOOK_VERTICAL
]

const PLAYER_INPUT_MAP_BUTTONS = [PlayerActions.JUMP]

extends Node

const JOYCON_DEADZONE = 0.5

const _JOYCON_INPUT_MAP = {0: "JUMP", 12: "FORWARD", 13: "BACKWARD", 14: "LEFT", 15: "RIGHT"}


func joycon_id_to_map(btn_id: int) -> String:
	return _JOYCON_INPUT_MAP[btn_id]


func joycon_map_to_id(map_str: String) -> int:
	for btn_id in _JOYCON_INPUT_MAP:
		if _JOYCON_INPUT_MAP[btn_id] == map_str:
			return btn_id

	return -1

#const KEYBOARD_INPUT_MAP = {
#	"KEY_32": "JUMP",
#	"KEY_87": "FORWARD",
#	"KEY_83": "BACKWARD",
#	"KEY_65": "LEFT",
#	"KEY_68": "RIGHT"
#}

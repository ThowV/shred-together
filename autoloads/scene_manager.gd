extends Node

onready var state_manager = get_node("/root/StateManager")


func _ready():
	state_manager.connect("state_switched", self, "_load_scene")


func _load_scene(state_prev, state_curr):
	if state_curr == state_manager.STATE.PLAY:
		var test_level = preload("res://scenes/levels/test_level.tscn").instance()
		add_child(test_level)

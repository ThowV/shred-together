extends Node


func _ready():
	var test_level = preload("res://scenes/levels/test_level.tscn").instance()
	add_child(test_level)

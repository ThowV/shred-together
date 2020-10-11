extends Node


func _ready():
	var test_level = preload("res://assets/TestLevel.tscn").instance()
	add_child(test_level)

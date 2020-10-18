extends Control

export (Resource) var game_manager_path


func _on_PlayButton_pressed():
	get_tree().change_scene(game_manager_path.resource_path)


func _on_QuitButton_pressed():
	get_tree().quit()

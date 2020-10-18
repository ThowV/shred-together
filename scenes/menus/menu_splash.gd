extends Control

export (Resource) var menu_main_path


func _input(event):
	if event is InputEventKey:
		go_menu_main()


func _on_AnimationPlayer_animation_finished(anim_name):
	go_menu_main()


func go_menu_main():
	get_tree().change_scene(menu_main_path.resource_path)

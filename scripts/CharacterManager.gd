extends Spatial

export (Resource) var character_path


func spawn_character(character_id) -> Node:
	var character = character_path.instance()
	character.name = "Character-" + str(character_id)
	character.translate(Vector3(0, 3, 0))

	add_child(character)

	return character

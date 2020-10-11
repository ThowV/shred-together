extends Node

export (Resource) var character_path

onready var vbox = $VBoxContainer
onready var hbox_top = $VBoxContainer/HBoxContainerTop
onready var hbox_middle = $VBoxContainer/HBoxContainerMiddle
onready var hbox_bottom = $VBoxContainer/HBoxContainerBottom

onready var viewport_containers = [
	$VBoxContainer/HBoxContainerTop/ViewportContainerL,
	$VBoxContainer/HBoxContainerTop/ViewportContainerM,
	$VBoxContainer/HBoxContainerTop/ViewportContainerR,
	$VBoxContainer/HBoxContainerMiddle/ViewportContainerL,
	$VBoxContainer/HBoxContainerMiddle/ViewportContainerM,
	$VBoxContainer/HBoxContainerMiddle/ViewportContainerR
]


func create_view(view_count: int):
	if view_count > 2:
		apply_constraints(hbox_middle)

	for idx in range(view_count):
		apply_constraints(viewport_containers[idx - 1])


func apply_constraints(container: BoxContainer):
	container.alignment = BoxContainer.ALIGN_CENTER
	container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.size_flags_vertical = Control.SIZE_EXPAND_FILL


func spawn_character(viewport_idx):
	var character = character_path.instance()
	character.name = "Character-" + str(viewport_idx)
	character.translate(Vector3(0, 3, 0))

	viewport_containers[viewport_idx].add_child(character)
	return character

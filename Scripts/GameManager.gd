extends Node

const SPEED = 250
const SPEED_MODIFIER_ACCELERATION = 2
const MENU_SCENE = "res://Scenes/UI/MainMenu.tscn"



func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files

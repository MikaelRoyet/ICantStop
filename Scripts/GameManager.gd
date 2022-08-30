extends Node

const SPEED = 300
const SPEED_MODIFIER_ACCELERATION = 2
const MENU_SCENE = "res://Scenes/UI/MainMenu.tscn"
const LEVEL_DATA = "res://Data/data_levels.json"

var levelDataDict

var presentLevel = "Menu"

func _ready():
	load_level_data()


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



func load_level_data():
	var data = File.new()
	if not data.file_exists(LEVEL_DATA):
		return # Error! We don't have a save to load.
		
	data.open(LEVEL_DATA, File.READ)
	var json = data.get_as_text()
	levelDataDict = JSON.parse(json).result
	print("init")
	print(levelDataDict)
	data.close()
	

func goToNextLevel():
	print(presentLevel)
	get_tree().change_scene("res://Scenes/Levels/" + levelDataDict[presentLevel.split('.')[0]]["nextLevel"] + ".tscn")
	presentLevel = levelDataDict[presentLevel.split('.')[0]]["nextLevel"]

	
	
func resetLevel():
	get_tree().reload_current_scene()

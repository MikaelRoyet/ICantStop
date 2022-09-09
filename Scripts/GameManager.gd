extends Node

const SPEED = 300
const SPEED_MODIFIER_ACCELERATION = 2
const MENU_SCENE = "res://Scenes/UI/MainMenu.tscn"
const LEVEL_DATA = "res://Data/data_levels.json"
const LEVEL_SAVE = "res://Data/data_level_save.json"
var levelDataDict
var levelSaveDict

var presentLevel = "Menu"
var currentLevel

func _ready():
	load_all_data()

#pas utilisé : renvoie la liste des fichiers dans dossier
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


#Charge les informations des niveaux dans un dictionnaire
func load_data(path):
	var data = File.new()
	if not data.file_exists(path):
		return # Error! We don't have a save to load.
		
	data.open(path, File.READ)
	var json = data.get_as_text()
	var dico = JSON.parse(json).result
	data.close()
	return dico

	
func load_all_data():
	levelDataDict = load_data(LEVEL_DATA)
	levelSaveDict = load_data(LEVEL_SAVE)
	
	
#Charge le niveau suivant en fonction du niveau actuel
func goToNextLevel():
	currentLevel.emitSignalNextLevel()



	
#Recharge le niveau actuel
func resetLevel():
	currentLevel.emitSignalLevel()

#Créer une particule et lance son émission à une position donné
func createParticle(particle, position):
		var iParticle = particle.instance()
		get_tree().root.add_child(iParticle)
		iParticle.position = position
		iParticle.restart()

#Attend pendent S seconde puis lance la méthode action sur l'objet object
func wait(s, action, object):
	var timer = Timer.new()
	timer.connect("timeout",object, action)
	timer.wait_time = s
	timer.one_shot = true
	add_child(timer)
	timer.start()

#Met a jour le niveau en cours (objet)
func setLevel(level):
	currentLevel = level

#Récupère le nom de niveau suivant dans le dico
func getNextLevel(level_name):
	var levelName = setPathForLevelName(levelDataDict[level_name]["nextLevel"])
	return levelName

#Revoie le chemin complet d'un niveau a partir de son nom
func setPathForLevelName(levelName):
	return "res://Scenes/Levels/" + levelName + ".tscn"

#Appelle la scene du menu principale
func goToMainMenu():
	currentLevel.emitSignalMenu()


func saveGame():
	var save_game = File.new()
	save_game.open(LEVEL_SAVE, File.WRITE)
	save_game.store_line(to_json(levelSaveDict))
	save_game.close()

func unlockLevel(level_name):
	levelSaveDict[levelDataDict[level_name]["nextLevel"]] = 1
	saveGame()

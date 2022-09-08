extends Control

signal level_changed(level_name)

onready var playButton : = $Panel/MainPanel/ButtonsContainer/PlayButton
onready var levelsButton : = $Panel/MainPanel/ButtonsContainer/LevelsButton
onready var optionsButton : = $Panel/MainPanel/ButtonsContainer/OptionsButton

onready var MainPanel : = $Panel/MainPanel
onready var LevelPanel : = $Panel/LevelPanel

onready var levelContainer : = $Panel/LevelPanel/LevelContainer

var LevelButton = load("res://Scenes/UI/ButtonLevel.tscn")
var worldSelected = 0
var levelDatas

func _ready():
	levelDatas = GameManager.levelDataDict
	LevelPanel.visible = false
	generateLevels()



#Lance le jeu 
func _on_PlayButton_pressed():
	emit_signal("level_changed", "res://Scenes/bacasable.tscn")

#Charge le menu des niveaux
func _on_LevelsButton_pressed():
	MainPanel.visible = false
	LevelPanel.visible = true
	print("levels")

#Charge le menu 
func _on_OptionsButton_pressed():
	print("options")


#Reviens  au menu principal
func _on_LevelButtonReturn_pressed():
	LevelPanel.visible = false
	MainPanel.visible = true


#Obselète?
func createButtonLevels():
	var listOfScene = GameManager.list_files_in_directory("res://Scenes/Levels")
	for scene in listOfScene:
		var button = Button.new()
		button.text = scene.split('.')[0]
		button.connect('pressed', self, 'on_levelButton_pressed', [scene])
		levelContainer.add_child(button)


#MLance le niveau correspondant au bouton
func on_levelButton_pressed(scene):
	GameManager.presentLevel = scene
	emit_signal("level_changed", "res://Scenes/Levels/" + scene)
	
	
#Génère les boutons des niveaux à partir d'un json
func generateLevels():

	for level in levelDatas:
		if levelDatas[level]["world"] == worldSelected:
			var levelHBox = LevelButton.instance()
			levelContainer.add_child(levelHBox)
			levelHBox.setAllValues(level, levelDatas[level]["name"])
			levelHBox.connect('pressed', self, 'on_levelButton_pressed', [levelDatas[level]["scene"]])

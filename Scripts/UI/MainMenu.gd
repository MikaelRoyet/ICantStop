extends Control

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




func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/bacasable.tscn")


func _on_LevelsButton_pressed():
	MainPanel.visible = false
	LevelPanel.visible = true
	print("levels")


func _on_OptionsButton_pressed():
	print("options")


func _on_LevelButtonReturn_pressed():
	LevelPanel.visible = false
	MainPanel.visible = true


func createButtonLevels():
	var listOfScene = GameManager.list_files_in_directory("res://Scenes/Levels")
	for scene in listOfScene:
		var button = Button.new()
		button.text = scene.split('.')[0]
		button.connect('pressed', self, 'on_levelButton_pressed', [scene])
		levelContainer.add_child(button)



func on_levelButton_pressed(scene):
	GameManager.presentLevel = scene
	get_tree().change_scene("res://Scenes/Levels/" + scene)
	
	
func generateLevels():

	for level in levelDatas:
		if levelDatas[level]["world"] == worldSelected:
			var levelHBox = LevelButton.instance()
			levelContainer.add_child(levelHBox)
			levelHBox.setAllValues(level, levelDatas[level]["name"])
			levelHBox.connect('pressed', self, 'on_levelButton_pressed', [levelDatas[level]["scene"]])

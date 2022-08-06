extends Control

onready var playButton : = $Panel/MainPanel/ButtonsContainer/PlayButton
onready var levelsButton : = $Panel/MainPanel/ButtonsContainer/LevelsButton
onready var optionsButton : = $Panel/MainPanel/ButtonsContainer/OptionsButton

onready var MainPanel : = $Panel/MainPanel
onready var LevelPanel : = $Panel/LevelPanel

onready var levelContainer : = $Panel/LevelPanel/LevelSeparator/LevelContainer



func _ready():
	LevelPanel.visible = false
	createButtonLevels()




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
		button.connect('pressed', self, 'on_levelButton_pressed')
		levelContainer.add_child(button)



func on_levelButton_pressed():
	print("pressed")

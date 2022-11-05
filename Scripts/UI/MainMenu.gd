extends Control

signal level_changed(level_name)



onready var MainPanel : = $Panel/MainPanel
onready var LevelPanel : = $Panel/LevelPanel
onready var InfoPanel : = $Panel/InfoPanel
onready var Title : = $Panel/MainPanel/Title
#onready var animTitle = $Panel/MainPanel/Title/TitleAnimationPlayer
onready var soundBtn : = $Panel/OptionsContainer/SoundButton
onready var iconSound : = preload("res://Sprites/UI/img/soundOn.png")
onready var iconMuted : = preload("res://Sprites/UI/img/soundMuted.png")

onready var levelContainer : = $Panel/LevelPanel/LevelContainer

var LevelButton = load("res://Scenes/UI/ButtonLevel.tscn")
var worldSelected = 0
var levelDatas

func _ready():
	#animTitle.play("TitleFloating")
	GameManager.setLevel(self)
	levelDatas = GameManager.levelDataDict
	LevelPanel.visible = false
	InfoPanel.visible = false
	generateLevels()
	
	#Audio
	if(AudioManager.isMute):
		soundBtn.icon = iconMuted
		soundBtn.pressed = true
	else:
		soundBtn.icon = iconSound


#Charge le menu des niveaux
func _on_LevelsButton_pressed():
	MainPanel.visible = false
	LevelPanel.visible = true
	InfoPanel.visible = false
	AudioManager.playSound(AudioManager.soundEffectPlop)
	refreshLevel()


func _on_InfoButton_pressed():
	MainPanel.visible = false
	LevelPanel.visible = false
	InfoPanel.visible = true
	AudioManager.playSound(AudioManager.soundEffectPlop)
	refreshLevel()

#Reviens  au menu principal
func _on_LevelButtonReturn_pressed():
	LevelPanel.visible = false
	MainPanel.visible = true
	InfoPanel.visible = false
	AudioManager.playSound(AudioManager.soundEffectPlop)



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
	AudioManager.playSound(AudioManager.soundEffectPlop)
	emit_signal("level_changed", "res://Scenes/Levels/" + scene)
	
	
#Génère les boutons des niveaux à partir d'un json
func generateLevels():

	for level in levelDatas:
		if levelDatas[level]["world"] == worldSelected:
			var levelHBox = LevelButton.instance()
			levelContainer.add_child(levelHBox)
			levelHBox.setAllValues(level, levelDatas[level]["numero"])
			levelHBox.connect('pressed', self, 'on_levelButton_pressed', [levelDatas[level]["scene"]])
			levelHBox.disabled = !GameManager.levelSaveDict[level]

func refreshLevel():
	for levelHBox in levelContainer.get_children():
		levelHBox.disabled = !GameManager.levelSaveDict["Level_" + levelHBox.text]

func _on_SoundButton_toggled(button_pressed):
	if button_pressed :
		soundBtn.icon = iconMuted
		AudioManager.muteSoundEffect(true)

	else :
		soundBtn.icon = iconSound
		AudioManager.muteSoundEffect(false)
		AudioManager.playSound(AudioManager.soundEffectPlop)
	



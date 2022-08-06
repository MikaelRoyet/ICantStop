extends Control

onready var playButton : = $Panel/MainPanel/ButtonsContainer/PlayButton
onready var levelsButton : = $Panel/MainPanel/ButtonsContainer/LevelsButton
onready var optionsButton : = $Panel/MainPanel/ButtonsContainer/OptionsButton

onready var MainPanel : = $Panel/MainPanel
onready var LevelPanel : = $Panel/LevelPanel


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelPanel.visible = false




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

extends Control

onready var playButton : = $Panel/ButtonsContainer/PlayButton
onready var levelsButton : = $Panel/ButtonsContainer/LevelsButton
onready var optionsButton : = $Panel/ButtonsContainer/OptionsButton
onready var quitButton : = $Panel/ButtonsContainer/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scene/bacasable.tscn")


func _on_LevelsButton_pressed():
	print("levels")


func _on_OptionsButton_pressed():
	print("options")


extends Node2D


signal level_changed(level_name)

export (String) var level_name = 'level'

func _ready():
	GameManager.setLevel(self)

func emitSignalNextLevel():
	print(level_name)
	GameManager.unlockLevel(level_name)
	emit_signal("level_changed", GameManager.getNextLevel(level_name))
	
func emitSignalLevel():
	print(level_name)
	emit_signal("level_changed", GameManager.setPathForLevelName(level_name))
	
func emitSignalMenu():
	print(level_name)
	emit_signal("level_changed", GameManager.MENU_SCENE)

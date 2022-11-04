extends Node


onready var soundEffectPlop = load("res://SoundEffect/plop1.wav")
onready var soundEffectBump = load("res://SoundEffect/BumpSoundEffect.wav")
onready var soundEffectDeath = load("res://SoundEffect/DeathSoundEffect.wav")

var AudioPlayer


func playSound(audioclip):
	AudioPlayer.stream = audioclip
	AudioPlayer.play()

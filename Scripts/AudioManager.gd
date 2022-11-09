extends Node


onready var soundEffectPlop = load("res://SoundEffect/plop1.wav")
onready var soundEffectBump = load("res://SoundEffect/BumpSoundEffect.wav")
onready var soundEffectDeath = load("res://SoundEffect/DeathSoundEffect.wav")
onready var soundEffectDash = load("res://SoundEffect/SoundEffectDash.wav")
onready var soundEffectTeleporter = load("res://SoundEffect/SoundEffectTeleporter.wav")
onready var soundEffectInterruptor = load("res://SoundEffect/soundEffectInterruptor.wav")
onready var soundEffectEnd = load("res://SoundEffect/SoundEffectEnd.wav")
onready var soundEffectAccel = load("res://SoundEffect/soundEffectAccel.wav")

var AudioPlayer
var isMute = false

func playSound(audioclip):
	AudioPlayer.stream = audioclip
	AudioPlayer.play()

func muteSoundEffect(pIsMute):
	isMute = pIsMute
	var master_sound = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_sound, isMute)

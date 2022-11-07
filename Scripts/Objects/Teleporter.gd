extends Area2D

export(NodePath) var arrivalPoint
var canTeleportPlayer
var canTeleportBumper

func _ready():
	canTeleportPlayer = true
	canTeleportBumper = true

var TeleportParticle = load("res://Scenes/Particles/TeleportParticle.tscn")

func _on_Teleporter_body_entered(body):
	if "Player" in body.name and canTeleportPlayer:
		var teleporter = get_node(arrivalPoint)
		body.moveToPoint(teleporter.position)
		teleporter.canTeleportPlayer = false
		GameManager.createParticle(TeleportParticle, teleporter.position, teleporter.rotation_degrees)
		
	elif "Bumper" in body.name and canTeleportBumper:
		var teleporter = get_node(arrivalPoint)
		body.moveToPoint(teleporter.position)
		teleporter.canTeleportBumper = false
		
	AudioManager.playSound(AudioManager.soundEffectTeleporter)



func _on_Teleporter_body_exited(body):
	if "Player" in body.name:
		canTeleportPlayer = true
	elif "Bumper" in body.name:
		canTeleportBumper = true

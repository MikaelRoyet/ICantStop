extends Area2D

export(NodePath) var arrivalPoint
var canTeleport

func _ready():
	canTeleport = true



func _on_Teleporter_body_entered(body):
	if "Player" in body.name and canTeleport:
		var teleporter = get_node(arrivalPoint)
		body.moveToPoint(teleporter.position)
		teleporter.canTeleport = false



func _on_Teleporter_body_exited(body):
	if "Player" in body.name:
		canTeleport = true

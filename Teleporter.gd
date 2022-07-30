extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var arrivalPoint
var canTeleport

# Called when the node enters the scene tree for the first time.
func _ready():
	canTeleport = true



func _on_Teleporter_body_entered(body):
	if "Player" in body.name and canTeleport:
		print("Enter TP")
		var teleporter = get_node(arrivalPoint)
		body.moveToPoint(teleporter.position)
		teleporter.canTeleport = false



func _on_Teleporter_body_exited(body):
	if "Player" in body.name:
		print("Leave TP")
		canTeleport = true

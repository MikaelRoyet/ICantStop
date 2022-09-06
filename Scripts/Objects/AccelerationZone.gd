extends Area2D


var speedModifier = GameManager.SPEED_MODIFIER_ACCELERATION


func _on_AccelerationZone_body_entered(body):
	if "Player" in body.name:
		body.modifySpeedModifier(speedModifier)


func _on_AccelerationZone_body_exited(body):
	if "Player" in body.name:
		body.modifySpeedModifier(1)

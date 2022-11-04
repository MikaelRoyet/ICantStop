extends Area2D


var speedModifier = GameManager.SPEED_MODIFIER_ACCELERATION

func _ready():
	var anim = get_node("AnimationPlayer").get_animation("colors")
	anim.set_loop(true)
	get_node("AnimationPlayer").play("colors")

func _on_AccelerationZone_body_entered(body):
	if body.is_in_group("Bumper") or body.is_in_group("Player"):
		body.modifySpeedModifier(speedModifier)


func _on_AccelerationZone_body_exited(body):
	if "Player" in body.name:
		body.modifySpeedModifier(1)

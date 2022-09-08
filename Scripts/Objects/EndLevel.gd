extends Area2D

func _on_EndLevel_body_entered(body):
	if body.is_in_group("Player"):
		body.stop()
		GameManager.goToNextLevel()

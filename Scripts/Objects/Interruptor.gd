extends Area2D


export (Color) var color
export var listBlocks = []

onready var sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = color


func activateBlocks():
	for block in listBlocks:
		get_node(block).changeVisibility()



func _on_Interruptor_body_entered(body):
	if body.is_in_group("Bumper") or body.is_in_group("Player"):
		AudioManager.playSound(AudioManager.soundEffectInterruptor)
		activateBlocks()

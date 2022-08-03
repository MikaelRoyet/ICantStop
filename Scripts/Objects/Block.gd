extends StaticBody2D


onready var sprite = $Sprite
onready var collision = $CollisionShape2D

export (Color) var color
export var isVisible = true


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = color
	if !isVisible:
		setVisibility()

func setVisibility():
	sprite.visible = isVisible
	collision.set_deferred("disabled", !isVisible)

func changeVisibility():
	isVisible = !isVisible
	setVisibility()

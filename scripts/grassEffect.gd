extends Node2D

onready var animatedSprite = $animatedSprite

func _ready():
	animatedSprite.play("default")

func _on_animatedSprite_animation_finished():
	queue_free()

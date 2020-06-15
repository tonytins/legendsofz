extends Control

export var max_health: int = 3

var health = max_health
onready var progress = $bar

func _process(delta):
	progress.value = health

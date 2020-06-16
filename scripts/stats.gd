extends Control

export var max_health: int = 3

onready var health = max_health setget set_health
onready var progress = $bar

signal no_health

func _process(delta):
	progress.value = health
	
func set_health(val):
	health = val
	if health <= 0:
		emit_signal("no_health")

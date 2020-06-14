extends Node2D

export var value: int = 0

func _on_hitBox_area_entered(area):
	PersistData.money += value
	queue_free()

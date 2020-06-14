extends Node2D

const grassEffect = preload("res://scenes/grassEffect.tscn")

func create_grass_effect():
	var effect: Node2D = grassEffect.instance()
	get_parent().add_child(effect)
	effect.global_position = global_position

func _on_hurtBox_area_entered(area):
	create_grass_effect()
	queue_free()

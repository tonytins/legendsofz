extends Control

onready var money = $money

func _process(delta):
	money.text = str(PersistData.money)

extends KinematicBody2D

var knockback = Vector2.ZERO
onready var stats = $stats

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_hurtBox_area_entered(area):
	stats.health -= area.damage
	if area.monitoring == true:
		stats.show()
		
	knockback = area.knockback_vector * 50

func _on_stats_no_health():
	queue_free()

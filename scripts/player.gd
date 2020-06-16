extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.RIGHT

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitBox = $hitBoxPivot/swordHitBack

func _ready():
	animationTree.active = true
	swordHitBox.knockback_vector = roll_vector

func _process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		ROLL:
			roll_state()
		
		ATTACK:
			attack_state()
	
func move_state(delta):	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitBox.knockback_vector = roll_vector
		animationTree.set("parameters/idle/blend_position", input_vector)
		animationTree.set("parameters/run/blend_position", input_vector)
		animationTree.set("parameters/attack/blend_position", input_vector)
		animationTree.set("parameters/roll/blend_position", input_vector)
		animationState.travel("run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	
	if Input.is_action_just_pressed("gm_roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("gm_attack"):
		state = ATTACK

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("attack")

func move():
	velocity = move_and_slide(velocity)
	
func roll_state():
	velocity = roll_vector * ROLL_SPEED
	move()
	animationState.travel("roll")
	
func roll_animation_finished():
	velocity = velocity * .8
	state = MOVE
	
func attack_animation_finished():
	state = MOVE

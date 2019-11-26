extends Area2D

const ACTIVE_TIME = 10

var timer
var activated

var collision
var sprite
var particles

func activate():
	if (timer == 0):
		activated = true
		timer = ACTIVE_TIME
		particles.emitting = true;

func _ready():
	collision = get_child(0)
	sprite = get_child(1)
	particles = get_child(2)
	
	timer = 0
	activated = false

func _process(delta):
	if (activated):
		sprite.show()
		particles.restart()
		activated = false
	
	if (timer > 0):
		timer -= 1
	else:
		sprite.hide()
		particles.emitting = false;

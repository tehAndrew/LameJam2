extends KinematicBody2D

const MAX_VEL = 350
const SIGNAL_TIME = 60

var vel = Vector2(0, 0)
var acc = 5
var keyPressed = false
var laser

var hasSignal = false
var signalTimer = 0

func _ready():
	set_process_input(true)
	laser = preload("res://scenes/Laser.tscn").instance()
	add_child(laser)

func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.scancode == KEY_SPACE:
			keyPressed = true
		elif not event.is_pressed() and event.scancode == KEY_SPACE:
			keyPressed = false
			if (hasSignal):
				laser.activate()
				signalTimer = SIGNAL_TIME

func _physics_process(delta):
	# Game
	if (keyPressed and hasSignal):
		if (vel.y > -MAX_VEL):
			vel.y -= acc
		else:
			vel.y = -MAX_VEL
	else:
		if (vel.y < MAX_VEL):
			vel.y += acc
		else:
			vel.y = MAX_VEL
			
	# Timer
	if (signalTimer > 0):
		hasSignal = false
		signalTimer -= 1
	else:
		hasSignal = true
	
	# Apply Motion
	vel = move_and_slide(vel, Vector2(0,-1))
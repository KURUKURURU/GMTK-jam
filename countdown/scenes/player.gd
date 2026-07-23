extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var steps = $steps

var SPEED := 300.0
const WALK_SPEED = 300.0
const RUN_SPEED = 400.0
const JUMP_VELOCITY = -400.0

# Slide variables
const SLIDE_BOOST = 600.0      # Starting burst of speed for the slide
var is_sliding := false
var slide_timer := 0.0
const SLIDE_DURATION = 1.0 # How long the slide lasts in seconds
var slide_direction := 0.0

var double_jump_active := false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_sliding = false # Cancel slide if jumping
	elif Input.is_action_just_pressed("jump") and !is_on_floor() and not double_jump_active and velocity.y < 0:
		velocity.y = JUMP_VELOCITY
		double_jump_active = true
		is_sliding = false
	elif is_on_floor():
		double_jump_active = false

	if not is_sliding:
		if Input.is_action_pressed("shift"):
			SPEED = RUN_SPEED
		else:
			SPEED = WALK_SPEED

	var direction := Input.get_axis("left", "right")

	#all conditions to slide
	if Input.is_action_just_pressed("slide") and is_on_floor() and Input.is_action_pressed("shift") and not is_sliding:
		is_sliding = true
		slide_timer = SLIDE_DURATION
		# Slide in the direction the player is moving, or facing if stationary
		slide_direction = direction if direction != 0 else (-1.0 if animation.flip_h else 1.0)
		velocity.x = slide_direction * SLIDE_BOOST
		animation.play("slide")

	if is_sliding:
		slide_timer -= delta
		velocity.x = move_toward(velocity.x, slide_direction * RUN_SPEED, (SLIDE_BOOST - RUN_SPEED) * (delta / SLIDE_DURATION))
		
		if slide_timer <= 0.0:
			is_sliding = false

	if not is_sliding:
		if direction != 0:
			if not steps.playing and is_on_floor():
				steps.play()
			
			velocity.x = direction * SPEED
			animation.flip_h = direction < 0

			if is_on_floor():
				if animation.animation != "run":
					animation.play("run")
		else:
			steps.stop()
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor() and animation.animation != "idle":
				animation.play("idle")
				
		# Airborn animations
		if !is_on_floor():
			steps.stop()
			if velocity.y < 0 and animation.animation != "jump":
				animation.play("jump")
			elif velocity.y > 0 and animation.animation != "fall":
				animation.play("fall")
	else:
		# Footsteps shouldn't play while sliding
		steps.stop() 

	move_and_slide()

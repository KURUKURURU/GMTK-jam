extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var steps = $steps
@onready var jump: AudioStreamPlayer2D = $jump

var moving : bool = true
var dead := false
var just_died = false

var SPEED := 300.0
const WALK_SPEED = 300.0
const RUN_SPEED = 500.0
const JUMP_VELOCITY = -400.0

# Slide variables
const SLIDE_BOOST = 800.0      # Starting burst of speed for the slide
var is_sliding := false
var slide_timer := 0.0
const SLIDE_DURATION = 1.0 # How long the slide lasts in seconds
var slide_direction := 0.0


var double_jump_active := false

func _physics_process(delta: float) -> void:
	# Add gravity universally regardless of state
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# INITIALIZE DIRECTION BEFORE PROCESSING
	var direction := 0.0

	if moving:
		direction = Input.get_axis("left", "right")
		
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump.play()
			velocity.y = JUMP_VELOCITY
			is_sliding = false # Cancel slide if jumping
		elif Input.is_action_just_pressed("jump") and !is_on_floor() and not double_jump_active and velocity.y < 0:
			jump.play()
			velocity.y = JUMP_VELOCITY
			double_jump_active = true
			is_sliding = false
		elif is_on_floor():
			double_jump_active = false

		if not is_sliding:
			if Input.is_action_pressed("shift"):
				SPEED = RUN_SPEED
				animation.speed_scale = 1.5
				steps.pitch_scale = 1.0
			else:
				SPEED = WALK_SPEED
				animation.speed_scale = 1.0
				steps.pitch_scale = 0.7
		else:
			direction = 0

		# all conditions to slide
		if Input.is_action_just_pressed("slide") and is_on_floor() and not is_sliding:
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

	# MOVEMENT PROCESSING LOGIC
	if not is_sliding and not dead: # Added "and not dead" to prevent ground overrides
		if moving and direction != 0:
			if not steps.playing and is_on_floor():
				steps.play()
			
			velocity.x = direction * SPEED
			animation.flip_h = direction < 0

			if is_on_floor():
				if animation.animation != "run":
					animation.play("run")
		else:
			# This safely stops the player if moving == false while they are still alive
			steps.stop()
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if is_on_floor() and animation.animation != "idle":
				animation.play("idle")
				
		# Airborne animations
		if !is_on_floor():
			steps.stop()
			if velocity.y < 0 and animation.animation != "jump":
				animation.play("jump")
			elif velocity.y > 0 and animation.animation != "fall":
				animation.play("fall")
	elif is_sliding:
		# Footsteps shouldn't play while sliding
		steps.stop() 
	
	# DEATH STATE LOGIC
	if dead:
		moving = false
		is_sliding = false # Ensure slide stops when dying
		steps.stop()       # Ensure footsteps stop immediately
		
		if !just_died:
			Global.gameover()
			velocity.y = JUMP_VELOCITY
			
			var alt = (1 if randf() > 0.5 else -1)
			
			velocity.x = alt * RUN_SPEED
			just_died = true
		
		match is_on_floor():
			true:
				velocity.x = move_toward(velocity.x, 0, SPEED) # Decelerate death flail on ground
				animation.play("dead")
			false:
				animation.play("flail")
	
	move_and_slide()

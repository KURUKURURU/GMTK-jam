extends Camera2D

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoom = Vector2(1.0, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("enlarge"):
		zoom.x += 0.05
		zoom.y += 0.05
		
		if zoom.x > 2.0:
			zoom.x = 2.0
			zoom.y = 2.0
		
	if Input.is_action_just_pressed("shrink"):
		zoom.x -= 0.05
		zoom.y -= 0.05
		
		if zoom.x < 1.0:
			zoom.x = 1.0
			zoom.y = 1.0
	
	if "dead" in player:
		if not player.dead:
			cameraUpdate() # follows the camera
		else:
			position = Vector2(0, 0)
	else:
		cameraUpdate()

func cameraUpdate():
	var pos = get_local_mouse_position()
	if pos.x >= -400 and pos.x < 400:
		set_position(pos)

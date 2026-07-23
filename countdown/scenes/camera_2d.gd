extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("enlarge"):
		zoom.x += 0.05
		zoom.y += 0.05
		
		if zoom.x > 1.5:
			zoom.x = 1.5
			zoom.y = 1.5
		
	if Input.is_action_just_pressed("shrink"):
		zoom.x -= 0.05
		zoom.y -= 0.05
		
		if zoom.x < 1.0:
			zoom.x = 1.0
			zoom.y = 1.0
	
	cameraUpdate() # follows the camera

func cameraUpdate():
	var pos = get_local_mouse_position()
	if pos.x >= -250 and pos.x < 250:
		set_position(pos)

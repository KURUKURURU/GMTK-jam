extends Path2D

@onready var path_follow: PathFollow2D = $PathFollow2D

# Movement properties
@export var speed: float = 200.0
@export var loop_path: bool = true

func _ready() -> void:
	path_follow.loop = loop_path

func _process(delta: float) -> void:
	path_follow.progress += speed * delta
	
	if not loop_path and path_follow.progress_ratio >= 1.0:
		set_process(false) # Stops running the _process loop
		print("Path done!")

extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@export var default_scene_path: String = ""

var current_target_path: String = ""
var progress: Array[float] = []
var is_loading: bool = false

func _ready() -> void:
	# Start loading the default scene on start
	start_threaded_load(default_scene_path)

func _process(_delta: float) -> void:
	if not is_loading:
		return
		
	var status = ResourceLoader.load_threaded_get_status(current_target_path, progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if progress.size() > 0:
				progress_bar.value = progress[0] * 100
		ResourceLoader.THREAD_LOAD_LOADED:
			is_loading = false
			var scene = ResourceLoader.load_threaded_get(current_target_path)
			get_tree().change_scene_to_packed(scene)
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			is_loading = false
			push_error("Failed to load scene at path: " + current_target_path)

# Call this function from anywhere whenever you want to start loading a new scene
func start_threaded_load(path: String) -> void:
	if path.is_empty():
		return
		
	current_target_path = path
	progress.clear()
	is_loading = true
	
	ResourceLoader.load_threaded_request(current_target_path)

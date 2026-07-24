extends Path2D
@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@onready var firework: StaticBody2D = $PathFollow2D/firework
@onready var blast: CanvasLayer = $blast

@onready var path_follow: PathFollow2D = $PathFollow2D

# Movement properties
@export var speed: float = 400.0
@export var loop_path: bool = true
@export var went: bool = false

@export var trigger : Area2D
@export var player : CharacterBody2D

var moving := false

func _ready() -> void:
	path_follow.progress = 0.0
	trigger.body_entered.connect(start_trail)
	path_follow.loop = loop_path

func _process(delta: float) -> void:
	if moving:
		path_follow.progress += speed * delta
		
	if not loop_path and path_follow.progress_ratio >= 1.0:
		set_process(false) # Stops running the _process loop
		print("Path done!")
		
		$boom.play()
		hide()
		

func start_trail(body: Node2D) -> void:
	if body == player and not went:
		went = true
		show()
		path_follow.progress = 0.0
		moving = true

func hit(body: Node2D) -> void:
	if body == player:
		if "dead" in player:
			blast.explode()
			player.dead = true

extends Node2D
@onready var floor: TileMapLayer = $Background/Parallax2D/floor
@onready var player: CharacterBody2D = $Entities/player
@onready var fireworks: Node2D = $Background/ParallaxBackground4/Firework

var start_position = Vector2(244, -193)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.restart.connect(_on_redo_pressed)
	
	fireworks.hide()
	fireworks.show()
	Pear.base.modulate = Color(1.0, 1.0, 1.0, 1.0)
	Pear.show()
	Pear._talk("Welcome to the City, Agent Apple.")
	
	Countdown.countdown(30)
	
	await Countdown.completed
	
	print("midnight!")
	
	Global.gameover()
	player.dead = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_floor_drop(body: Node2D) -> void:
	if body == player:
		player.dead = true


func _on_redo_pressed() -> void:
	get_tree().reload_current_scene()

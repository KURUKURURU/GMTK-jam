extends Node2D
@onready var floor: TileMapLayer = $Background/Parallax2D/floor
@onready var player: CharacterBody2D = $Entities/player
@onready var fireworks: Node2D = $Background/ParallaxBackground4/Firework


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fireworks.hide()
	Pear.base.modulate = Color(1.0, 1.0, 1.0, 1.0)
	Pear.show()
	await Pear._talk("Welcome to the City, Agent Apple.")
	
	#Countdown.countdown(10)
	#await Countdown.completed
	
	print("midnight!")
	fireworks.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_floor_drop(body: Node2D) -> void:
	if body == player:
		player.dead = true

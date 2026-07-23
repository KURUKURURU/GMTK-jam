extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Pear._talk("Welcome to the City, Agent Apple.", true, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

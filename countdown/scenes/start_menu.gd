extends Node2D
@onready var pickup: TextureButton = $pickup
@onready var ringing: AudioStreamPlayer = $ringing
@onready var animation: AnimationPlayer = $animation
@onready var music: AudioStreamPlayer = $music
@onready var talk: AnimatedSprite2D = $TextureRect/talk


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickup.show()
	Pear.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pickup_pressed() -> void:
	ringing.stop()
	pickup.hide()
	music.play()
	
	animation.play("pickup")
	await animation.animation_finished
	
	Pear.base.modulate = Color(0.0, 0.0, 0.0, 1.0)
	Pear.show()
	
	await Pear._talk("Happy New Years, Agent Apple.")
	await Pear._talk("We need your help.")
	
	await Pear._talk("It seems like the Y2K theory might be true, based on new intelligence.")
	
	animation.play("waybackworm")
	await Pear._talk("The nation's common enemy, Mr Wayback Worm, is planning worldwide destruction.")
	
	animation.play("pearintro")
	await Pear._talk("Only you can stoip this, Apple. Agent Pear signing out.")
	talk.play("stop")
	animation.play("")
	
	Pear.base.modulate = Color(1.0, 1.0, 1.0, 1.0)

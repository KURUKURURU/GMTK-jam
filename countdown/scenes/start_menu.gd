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
	
	animation.play("newyears")
	await Pear._talk("The City's Super Computer, located in the City's main office building, hasn't been updated.")
	await Pear._talk("As soon as midnight passes, 2000 will be simply 1900 for the computer,")
	await Pear._talk("Then all chaos will break lose.")
	await Pear._talk("He's planning to thwart any plan and stop anyone who attempts to debug the computer, in order to further his agenda.")
	
	animation.play("newyearsday")
	await Pear._talk("Only you can stop this, Apple.")
	await Pear._talk("You must save New Years Day, by any means neccesary.")
	
	animation.play("pearintro")
	await Pear._talk("I have equipped you with a DEBUGGER,")
	talk.hide()
	Pear.base.modulate = Color(1.0, 1.0, 1.0, 1.0)
	animation.play("debugger")
	await Pear._talk("It will help you debug any problem and once plugged into the super computer update it to the 2000s.")
	
	Pear.base.modulate = Color(0.0, 0.0, 0.0, 1.0)
	animation.play("pearintro")
	talk.show()
	await Pear._talk("Agent Pear signing out.")
	talk.play("stop")
	Pear.advance.emit()
	Pear.hide()
	
	animation.play("final")
	Loading.start_threaded_load("res://scenes/city_level.tscn")


func start_game() -> void:
	$buttons.hide()
	ringing.play()
	$pickup.show()

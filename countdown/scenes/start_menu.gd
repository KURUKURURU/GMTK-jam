extends Node2D
@onready var pickup: TextureButton = $pickup
@onready var ringing: AudioStreamPlayer = $ringing
@onready var animation: AnimationPlayer = $animation


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
	
	
	animation.play("pickup")
	await animation.animation_finished
	
	Pear.base.modulate = Color(0.0, 0.0, 0.0, 1.0)
	Pear.show()
	
	await Pear._talk("Agent Apple.")
	await Pear._talk("We need your help.")
	
	Pear.base.modulate = Color(1.0, 1.0, 1.0, 1.0)

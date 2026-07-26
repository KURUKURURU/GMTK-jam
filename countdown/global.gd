extends Node2D
@onready var animation: AnimationPlayer = $animation

@onready var _gameover: AudioStreamPlayer = $gameover
@onready var gameover_screen = $Gameover_Screen

signal restart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func gameover():
	_gameover.play()
	animation.play("gameover")
	gameover_screen.show()
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _on_button_pressed() -> void:
	restart.emit()
	gameover_screen.hide()

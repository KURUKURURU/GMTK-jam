extends CanvasLayer

@onready var animation: AnimationPlayer = $bubble/animation
@onready var label: RichTextLabel = $bubble/MarginContainer/NinePatchRect/RichTextLabel
@onready var bubble: Node2D = $bubble
@onready var bubble_sfx: AudioStreamPlayer2D = $bubble/bubble
@onready var advance_: RichTextLabel = $"bubble/advance?"

@onready var base: AnimatedSprite2D = $base
@onready var talk: AnimatedSprite2D = $talk

var animation_last_played : String

signal advance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bubble.hide()
	advance_.show()
	#_talk("Heyyyyyyyy.", false, true, true) #test


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Q"):
		advance.emit()

func _talk(message:= "...", talking:= true, prompted:= true, first_play := false):
	label.text = ""
	bubble.show()
	advance_.hide()
	
	if first_play:
		animation.play("open")
		await animation.animation_finished
	
	if talking or message != "...":
		talk.play("talk")
	
	animation.play("type")
	bubble_sfx.play()
	label.text = message
	await animation.animation_finished
	
	if prompted:
		advance_.show()
		await advance
	
	if talk.animation == "talk":
		talk.play("stop")
	
	bubble.hide()

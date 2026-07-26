extends StaticBody2D
@onready var door_open = $door_open
@onready var door_close = $door_close
@onready var base: TextureRect = $base
@onready var area_2d: Area2D = $Area2D

@onready var close_coll: CollisionShape2D = $door_close/c_coll
@onready var open_coll: CollisionShape2D = $door_open/o_coll
@onready var loop: AnimationPlayer = $TextureRect/loop
@onready var img: TextureRect = $TextureRect

@export var player : CharacterBody2D
@onready var yay: AudioStreamPlayer = $yay
@onready var unlock: AudioStreamPlayer = $unlock


var played := false

signal advance

func _ready() -> void:
	img.hide()
	close_door(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#if Input.is_action_pressed("Q"):
		#if loop.current_animation != "hold":
			
	
	if Input.is_action_just_pressed("Q"):
		loop.play("hold")
		await Global.wait(0.1)
		advance.emit()

func quicktime():
	
	if played:
		return
		
	loop.play("click")
	var random = randi_range(5,10)
	
	for i in range(random):
		loop.play("click")
		await advance
		unlock.play()
	
	yay.play()
	played = true
	return

func close_door(closed : bool):
	match closed:
		true: 
			door_close.show()
			door_open.hide()
			close_coll.disabled = false
			return
		false: 
			door_close.hide()
			door_open.show()
			close_coll.disabled = true
			return


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		img.show()
		await quicktime()
		img.hide()
		close_door(false)

extends PhysicsBody2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D2
@onready var sprite: Sprite2D = $Sprite2D
@onready var __break: AudioStreamPlayer2D = $break

@export var player : CharacterBody2D

func _ready() -> void:
	pass # Replace with function body.
func _process(delta: float) -> void:
	pass

func place():
	collision_shape.set_deferred("disabled", false)
	show()

func _break():
	collision_shape.set_deferred("disabled", true)
	__break.play()
	hide()

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if "is_sliding" in player:
			if player.is_sliding:
				_break()

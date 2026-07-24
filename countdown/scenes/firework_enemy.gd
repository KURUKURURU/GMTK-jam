extends StaticBody2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var area_2d: Area2D = $Area2D
@onready var hitbox: CollisionPolygon2D = $Area2D/CollisionPolygon2D2

@export var player : CharacterBody2D

func _ready() -> void:
	pass # Replace with function body.
func _process(delta: float) -> void:
	pass

func place():
	show()

func _break():
	hide()

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if "dead" in player:
			player.dead = true

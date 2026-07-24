extends StaticBody2D

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

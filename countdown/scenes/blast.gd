extends CanvasLayer
@onready var boom: AudioStreamPlayer = $boom
@onready var sizzle: AudioStreamPlayer = $sizzle
@onready var color_rect: ColorRect = $ColorRect

func explode():
	show()
	boom.play()
	sizzle.play()
	

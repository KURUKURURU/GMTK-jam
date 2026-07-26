extends CanvasLayer
@onready var label: RichTextLabel = $label
@onready var tick: AudioStreamPlayer2D = $tick

var minutes 
var seconds 

signal completed

func _ready() -> void:
	hide()
	#await countdown(61)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func countdown(time):
	show()
	minutes = int(time / 60.0)
	seconds = time % 60
	
	for i in range(time):
		if seconds < 0:
			if minutes != 0:
				minutes -=1
				seconds = 59
			else:
				label.text = "0:00"
				break
		
		var add: String
		
		if seconds < 10:
			add = "0"
		else: add = ""
		
		label.text = str(minutes) + ":" + add + str(seconds)
		await Global.wait(1.0)
		tick.play()
		seconds -= 1
		
	print("timer done!")
	completed.emit()
	hide()
	return

extends Sprite

var jumpPosition = 615

export var speed = 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	position.y += speed
	
	if position.y >= jumpPosition:
		position.y = -jumpPosition

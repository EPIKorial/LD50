extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	$Button.connect("pressed", Callable(self, "_button_pressed"))

func _button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


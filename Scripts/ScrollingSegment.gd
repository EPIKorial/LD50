extends Node2D

var jumpPosition = 615

@export var speed = 1

var bgs = []
var bgPathRoot = "res://Prefabs/Background"
var bgPathEnd = ".tscn"

@onready var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	bgs.append(get_node("Background"))
	bgs.append(get_node("Background2"))

func _process(delta):
	if bgs.front() == null || bgs.back() == null:
		return
	bgs.front().position.y += speed
	bgs.back().position.y += speed
	
	var rand = str(rng.randi_range(1, 5))
	
	if bgs.front().position.y >= jumpPosition:
		bgs.front().position.y = -jumpPosition
		var newBG = load(bgPathRoot+rand+bgPathEnd).instantiate()
		newBG.position = bgs.front().position
		bgs.append(newBG)
		add_child(newBG)
		if bgs.size() > 2:
			bgs.remove_at(0)
	if bgs.back().position.y >= jumpPosition:
		bgs.back().position.y = -jumpPosition
		var newBG = load(bgPathRoot+rand+bgPathEnd).instantiate()
		newBG.position = bgs.back().position
		bgs.append(newBG)
		add_child(newBG)
		if bgs.size() > 2:
			bgs.remove_at(1)

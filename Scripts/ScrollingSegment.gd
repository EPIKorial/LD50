extends Node2D

var jumpPosition = 615

export var speed = 1

var bgs = []

func _ready():
	bgs.append(get_node("Background"))
	bgs.append(get_node("Background2"))

func _process(delta):
	if bgs.front() == null || bgs.back() == null:
		return
	bgs.front().position.y += speed
	bgs.back().position.y += speed
	
	if bgs.front().position.y >= jumpPosition:
		bgs.front().position.y = -jumpPosition
		var newBG = load("res://Prefabs/Background2.tscn").instance()
		newBG.position = bgs.front().position
		bgs.append(newBG)
		add_child(newBG)
		if bgs.size() > 2:
			bgs.remove(0)
	if bgs.back().position.y >= jumpPosition:
		bgs.back().position.y = -jumpPosition
		var newBG = load("res://Prefabs/Background2.tscn").instance()
		newBG.position = bgs.back().position
		bgs.append(newBG)
		add_child(newBG)
		if bgs.size() > 2:
			bgs.remove(1)

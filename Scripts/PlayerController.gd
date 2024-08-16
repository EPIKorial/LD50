extends CharacterBody2D

@export var speed = 200

var defrosting = 1000
var defrostingTotal = defrosting
var score = 0
var _velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	get_node("/root/Node2D/Control/Button").connect("pressed", Callable(self, "_button_pressed"))
	get_node("/root/Node2D/Control/Button").hide()
	get_node("AnimatedSprite2D").play("default")

func get_input():
	#print(defrosting)
	
	_velocity = Vector2()
	if Input.is_action_pressed("right"):
		_velocity.x += 1
	if Input.is_action_pressed("left"):
		_velocity.x -= 1
	if Input.is_action_pressed("down"):
		_velocity.y += 1
	if Input.is_action_pressed("up"):
		_velocity.y -= 1
	_velocity = _velocity.normalized() * speed

func _button_pressed():
	get_tree().reload_current_scene()

func _physics_process(delta):
	get_input()
	set_velocity(_velocity)
	move_and_slide()
	_velocity = _velocity
	
	var space_state = get_world_2d().direct_space_state
	var params = PhysicsRayQueryParameters2D.new()
	var to = get_node("/root/Node2D/PointLight2D").position
	params.from = to
	params.to = position
	params.exclude = [self, get_node("/root/Node2D/Boundaries/CharacterBody2D")]
	var result = space_state.intersect_ray(params)

	score += 0.1
	get_node("/root/Node2D/Control/score").text = "Score: %s" % score
	
	if !result.is_empty():
		print("defrosting")
		defrosting -= 0.1
	else:
		print("melting")
		defrosting -= 1
		
	if defrosting <= 0:
		get_node("/root/Node2D/Control/Button").show()
		get_tree().paused = true
		
	process_melting()
	
func process_melting():

	var OldRange = defrostingTotal
	var NewRange = 1.75
	var NewValue = (((defrosting) * NewRange) / OldRange)
	print(NewValue)

	if NewValue > 0.4:
		self.scale.x = NewValue
		self.scale.y = NewValue
	get_node("GPUParticles2D").process_material.scale_max = NewValue / 3

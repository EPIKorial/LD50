extends KinematicBody2D

export (int) var speed = 200

var defrosting = 1000
var defrostingTotal = defrosting
var score = 0
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	get_node("/root/Node2D/Control/Button").connect("pressed", self, "_button_pressed")
	get_node("/root/Node2D/Control/Button").hide()

func get_input():
	#print(defrosting)
	
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _button_pressed():
	get_tree().reload_current_scene()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, get_node("/root/Node2D/Light2D").position, [self, get_node("/root/Node2D/Boundaries/KinematicBody2D")])

	score += 0.1
	get_node("/root/Node2D/Control/score").text = "Score: %s" % score
	
	if !result.empty():
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

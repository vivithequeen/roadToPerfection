extends CharacterBody2D
var isPokoable : bool = true
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DISTANCE = 200

# DEPENDECIES
# Globals:
	# player position plrPos : Vector2
		# Make sure player is constantly updating this position
	# boss position bossPos : Vector2
		# Make sure boss is constantly updating this position
	# boolean spawnProj
		# Starts as false

var rng = RandomNumberGenerator.new()
var dir = 1
var dashDir = 1
var goTo : Vector2
var restPos : Vector2

var phase = 1
var health = 75
var distToPlr : int
var tiredCount = 1

func _ready():
	print("penis")
	position = Vector2i(660, 360)

func _physics_process(_delta) -> void:
	Global.bossPos = position
	#distToPlr = sqrt(pow(position.x-Global.plrPos.x, 2) + pow(position.y-Global.plrPos.y, 2))
	
	if phase == 1:
		var shootRNG = rng.randi_range(0, 100)
		var switchRNG = rng.randi_range(20, 100)
		
		goTo = Vector2(Global.plrPos.x + DISTANCE*dir, Global.plrPos.y - DISTANCE)
		
		if shootRNG == 100:
			get_parent().spawnProj()
			
		if switchRNG == 100:
			dir *= -1
	
	if phase == 2:
		goTo = Vector2(Global.plrPos.x + 300 * dashDir, Global.plrPos.y)
	
	if phase == 3:
		$Sprite2D.texture = load("res://resources/png/boss man tired (1).png")
		goTo = restPos
	else:
		$Sprite2D.texture = load("res://resources/png/boss man (1).png")
	
	
	if phase != 2:
		if position.distance_to(goTo) < 5:
			velocity = Vector2.ZERO
		else:
			velocity = position.direction_to(goTo) * SPEED
	else:
		if position.distance_to(goTo) < 5:
			dashDir *= -1
		else:
			velocity = position.direction_to(goTo) * SPEED * 1.75
	
	

	
	if health == 0:
		queue_free()

	move_and_slide()

func _on_timer_timeout() -> void:
	if tiredCount == 3: # Resting phase
		restPos = Vector2(Global.plrPos.x + 200, Global.plrPos.y)
		$Timer.wait_time = 5
		phase = 3
		tiredCount = 0
	elif phase == 2: # Dashing phase
		$Timer.wait_time = 7
		phase = 1
		tiredCount += 1;
	else: # Shooting phase
		$Timer.wait_time = 10
		phase = randi_range(1, 2) # Replace with function body.
		tiredCount += 1



func _on_area_2d_area_entered(area:Area2D):
	print(area)
	if area.name == "pokoArea":
		health-=1;
		$AudioStreamPlayer.play()

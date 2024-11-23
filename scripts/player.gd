extends CharacterBody2D

var health = 20;
var isPokoable : bool = false
const SPEED := 300.0
const JUMP_VELOCITY := -550.0



var doubleJumpCounter : int = 1;

var lastFacedDirection : int = 0;
@onready var currentAttackWeapon : Node2D = $playerBasicSword
#var jumpButtonPressTime : int = 0;

var isAttacking : bool = false
var attackQueue : Array = []
var lastDirection : int = -1

var isDashing = false
var dashTimer = 0
var dashCount = 2
var dashVelocity := 0
func _physics_process(delta):
	Global.plrPos = position
	# Add the gravity.
	#if Input.is_action_pressed("jump"):
	#	jumpButtonPressTime += delta
	if not is_on_floor():
		if !isDashing:
			velocity += get_gravity() * delta
		else:
			velocity +=(get_gravity()/20) * delta

	# Handle jump.
	if Input.is_action_pressed("right"):
		lastFacedDirection = 0;
	elif Input.is_action_pressed("left"):
		lastFacedDirection = 2;
	if Input.is_action_just_pressed("LMB"):
		attackQueue.append(true)
	#double jumps
	if Input.is_action_pressed("dash"):
		if dashTimer > 0.1 and dashCount > 0:
			dash()
	if Input.is_action_just_pressed("jump") and doubleJumpCounter >0:
		if doubleJumpCounter > 0:
			doubleJumpCounter -=1
			velocity.y = JUMP_VELOCITY
		
	if is_on_floor():
		doubleJumpCounter = 1
		dashCount = 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		if (velocity.x < 300.0 and velocity.x > -300.0):
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#print(attackQueue)
	if (!attackQueue.is_empty()) and (attackQueue[0]) and !isAttacking:
		attackQueue.remove_at(0)
		basicAttack()
	if isDashing:
		velocity.x=delta * 75000 * (1 if lastFacedDirection == 0 else -1)
	else:
		dashTimer+=delta
	move_and_slide()



func basicAttack() -> void:
	if currentAttackWeapon.attackType == "instant":
		isAttacking = true
		currentAttackWeapon.attack(lastFacedDirection)

func pokoJump(v) -> void:
	velocity = v
	doubleJumpCounter = 1
	dashCount = 2

func dash() -> void:
	print("Hi!")
	velocity.y = 0
	dashTimer = 0
	dashCount -=1
	isDashing = true
	$dashTimer.start()
	#if dashTimer != 1:
	#	dashVelocity = 1500 * (1 if lastFacedDirection == 0 else -1)
	#dashTimer = 1
func _on_dash_timer_timeout():
	velocity.x = 0;
	isDashing = false
	


func _on_area_2d_body_entered(body:Node2D):
	print(body.name)
	if body.has_method("e"):
		health-=1

extends Node2D

var attackType : String = "instant";
var isActive : bool = false


@onready var area : Area2D = $Area2D 
@onready var attackTimer : Timer = $attackTimer
@onready var pokoArea : Area2D = $pokoArea


# Called when the node enters the scene tree for the first time.
func _ready():
	update(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack(direction):
	if Input.is_action_pressed("up"):
		rotation = deg_to_rad(270)
	elif Input.is_action_pressed("down") and !get_parent().is_on_floor():
		rotation = deg_to_rad(90)
	else:
		match direction:
			0:
				rotation = 0
			1:
				rotation = deg_to_rad(90)
			2:
				rotation = deg_to_rad(180)
			3:
				rotation = deg_to_rad(270)
	isActive = true
	update(isActive)
	attackTimer.start()
	

func _on_attack_timer_timeout():
	get_parent().isAttacking = false
	isActive = false
	
	update(isActive)


func update(a):
	visible = a
	pokoArea.monitoring = a
	pokoArea.monitoring = a
	area.monitoring = a
	area.monitorable = a


#func getAttackAngle(input)

func _on_poko_area_body_entered(body:Node2D):
	
	if body.isPokoable:
		$GPUParticles2D.emitting = true
		if (str(rotation).substr(0,4) == str(deg_to_rad(90)).substr(0,4)):
			get_tree().call_group("player", "pokoJump", Vector2(0,1) * -550.0)

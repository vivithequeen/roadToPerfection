extends Node2D

@export var playerLocation : CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	maintainDistance(delta)


func maintainDistance(delta) -> void:
	var distanceFromPlayer = playerLocation.position.x + 20 * (-1 if position.x > playerLocation.position.x else 1)

	position.x+=move_toward(position.x, playerLocation.position.x + distanceFromPlayer, delta)
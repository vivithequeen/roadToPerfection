extends Node2D

@onready var projectile = preload("res://scenes/projectile.tscn")
@onready var projScript = load("res://scripts/projectile_clone.gd")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _physics_process(delta):
	$ui/ProgressBar.value = 75-$enemy.health
	$ui/ProgressBar2.value = 75-$enemy.health
	$ui/ProgressBar3.value = 20-$player.health
	$ui/ProgressBar4.value = 20-$player.health
	if $enemy.health <= 0:
		get_tree().change_scene_to_file("res://scenes/win.tscn")
	if $player.health <= 0:
		get_tree().change_scene_to_file("res://scenes/lost.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawnProj():
	var newProj = projectile.instantiate()
	newProj.set_script(projScript)
	add_child(newProj)
	
	

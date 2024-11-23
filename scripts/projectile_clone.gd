extends Node2D

var SPEED = 100
var isPokoable : bool = true
var target = Global.plrPos
var startPos = Global.bossPos
var velocity

var randomSprite = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spriteNum = randomSprite.randi_range(0, 2)
	var sprites = [
		load("res://resources/png/baddecision-proj.png"),
		load("res://resources/png/obey-proj.png"),
		load("res://resources/png/bebetter-proj.png")
	]
	var sounds = [
		load("res://resources/audio/bad_decision_audio(1).mp3"),
		load("res://resources/audio/obey_audio(1).mp3"),
		load("res://resources/audio/be_better_audio(1).mp3")
	]
	for i in range(0, get_child_count()):
		if get_child(i).name == "moralSprite":
			(get_child(i) as Sprite2D).texture = sprites[spriteNum]
			i = get_child_count()
	for i in range(0, get_child_count()):
		if get_child(i).name == "AudioStreamPlayer2D":
			(get_child(i) as AudioStreamPlayer2D).stream = sounds[spriteNum]
			i = get_child_count()
	$AudioStreamPlayer2D.play()
	
	position = startPos
	look_at(target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += (target-startPos).normalized() * delta *1000
	
	#if position.y < 0 or position.x < 0 or position.x > 720:
	#	queue_free()
	#	#print("gone")
	
func e():
	pass

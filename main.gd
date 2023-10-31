extends Node

var scroll : int = 0
signal scroll_change
var health : int = 4
signal game_over

func _process(_delta):
	if health <= 0:
		print("died :(")
		emit_signal("game_over")
		get_tree().paused = true

func _physics_process(_delta):
	scroll += 1
	emit_signal("scroll_change",scroll)

extends Node2D

#measured in seconds
var time : int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#await get_tree().create_timer(1.0).timeout
	time += 1
	print(time)

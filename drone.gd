extends enemy

const speed = 1

var target : Node2D

func _ready():
	$Area2D.connect("body_entered", Callable(self, "on_body_entered"))

func _init():
	super(10)

func init(player : Node2D):
	target = player

func _process(_delta):
	if !target:
		target = get_target()
	if health <= 0:
		self.queue_free()

func get_target() -> Node2D:
	return target

func on_body_entered(a):
	health -=1

extends RigidBody2D

var _direction : Vector2

func init(direction : Vector2, speed: int, force : int, spray : float):
	_direction = direction
	apply_central_impulse(speed*(direction+Vector2(randf_range(-spray,spray),randf_range(-spray,spray))))

func _ready():
	$Area2D.connect("body_entered", Callable(self, "on_body_entered"))
	await get_tree().create_timer(5.0).timeout
	self.queue_free()

func on_body_entered(a):
	if a.is_in_group("enemy"):
		self.queue_free()

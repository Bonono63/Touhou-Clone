extends CharacterBody2D

const REGULAR = 350
const PRECISE = 200

var SPEED : int = REGULAR

var w : bool
var a : bool
var s : bool
var d : bool
var shoot : bool
var precise : bool
var gun_timer = Timer.new()
var fire_rate := 0.0625

var mouse_coords : Vector2

signal precise_active

func _ready():
	add_child(gun_timer)
	gun_timer.connect("timeout", Callable(self, "on_shoot"))
	$Hitbox.connect("body_entered", Callable(self, "on_body_entered"))
	connect("precise_active", Callable(self, "precise_toggled"))
	position.x = (get_viewport_rect().size.x/2)+16
	position.y = (get_viewport_rect().size.y)-48

func precise_toggled(b : bool):
	if b:
		$Sprite.modulate = Color.AQUA
	else:
		$Sprite.modulate = Color.WHITE

func on_shoot():
	var bullet = preload("res://bullet.tscn").instantiate()
	var speed := 2000
	var force := 1
	var direction : Vector2 = Vector2(0,-1)#global_position.direction_to(mouse_coords)
	var time := 0.05
	var spray : float = 0.0
	bullet.position = position + (32*direction)
	bullet.rotation_degrees = -90#global_position.angle_to_point(mouse_coords)
	var bullet_front = bullet.duplicate()
	var bullet_left = bullet.duplicate()
	var bullet_right = bullet.duplicate()
	bullet_front.init(direction+Vector2(0.0625,0),speed,force,spray)
	bullet_left.init(direction+Vector2(-0.0625,0),speed,force,spray)
	bullet_right.init(direction,speed,force,spray)
	get_parent().add_child(bullet_front)
	get_parent().add_child(bullet_left)
	get_parent().add_child(bullet_right)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_pressed("w"):
			w = true
		if event.is_action_released("w"):
			w = false
		
		if event.is_action_pressed("a"):
			a = true
		if event.is_action_released("a"):
			a = false
		
		if event.is_action_pressed("s"):
			s = true
		if event.is_action_released("s"):
			s = false
		
		if event.is_action_pressed("d"):
			d = true
		if event.is_action_released("d"):
			d = false
		
		if event.is_action_pressed("precise"):
			precise = true
			emit_signal("precise_active", true)
		if event.is_action_released("precise"):
			precise = false
			emit_signal("precise_active", false)
		
		if event.is_action_pressed("shoot"):
			shoot = true
			on_shoot()
			gun_timer.start(fire_rate)
		if event.is_action_released("shoot"):
			shoot = false
			gun_timer.stop()
	
	if event is InputEventMouseButton:
		pass

func _physics_process(delta):
	if precise:
		SPEED = PRECISE
		
	else:
		SPEED = REGULAR
	
	if w or s:
		velocity.y = SPEED
		if w:
			velocity.y *=-1
		if s:
			velocity.y *=1
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if a or d:
		velocity.x = SPEED
		if a:
			velocity.x *=-1
		if d:
			velocity.x *=1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	#dget_viewport_rect().size.x
	position.x = clamp(position.x, 0+(32/2), get_viewport_rect().size.x-16)
	position.y = clamp(position.y, 0+(32/2), get_viewport_rect().size.y-16)

func on_body_entered(body):
	if body.is_in_group("enemy"):
		Main.health -=1

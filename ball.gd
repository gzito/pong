class_name Ball
extends Area2D

const MAX_SPEED = 3200
@export var speed: float = 750.0
@export var direction: Vector2 = Vector2(-1,-1).normalized()
@export var accel: float = 50.0

@onready var _half_height: float = $ColorRect.size.y / 2.0
@onready var _initial_position: Vector2 = position
@onready var _initial_speed: float = speed
#var _old_pos: Vector2

func _physics_process(delta: float) -> void:
	#_old_pos = position
	position += direction * speed * delta
	
func get_center_y() -> float:
	return position.y + _half_height

func reset() -> void:
	#_old_pos = Vector2.ZERO
	position = _initial_position
	direction.x = randi_range(0,1)
	if direction.x == 0:
		direction.x = -1
	direction.y = randf_range(-1,1)
	direction = direction.normalized()
	speed = _initial_speed

func accelerate() -> void:
	speed += accel
	if speed > MAX_SPEED:
		speed = MAX_SPEED

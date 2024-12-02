class_name Ball
extends Area2D

@export var speed: float = 350.0
@export var direction: Vector2 = Vector2(-1,-1).normalized()
@export var accel: float = 50.0
@onready var _half_height: float = $ColorRect.size.y / 2.0
@onready var _initial_position: Vector2 = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta

func get_center_y() -> float:
	return position.y + _half_height

func reset() -> void:
	position = _initial_position
	direction = Vector2.RIGHT
	
func accelerate() -> void:
	speed += accel

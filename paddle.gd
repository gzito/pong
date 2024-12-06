extends Area2D

@export var humanControlled: bool = true

const CPU_PADDLE_VSPEED : int = 350
var cpu_vel_y : float = 0

@onready var _half_height : float = $ColorRect.size.y / 2.0
@onready var field_node = get_node("/root/Field")

func _physics_process(delta: float) -> void:
	if humanControlled:
		var displacement = DisplayServer.mouse_get_position().y
		var winpos = get_window().position.y
		var relativeY = displacement- winpos
		if relativeY > 0:
			if relativeY + $ColorRect.size.y < get_window().size.y:
				position.y = displacement - winpos
	else:
		var ball: Ball = field_node.ball as Ball
		var half_screen_height: int = floori(get_window().size.y / 2)
		var paddle_center_y = position.y + _half_height
		# ball is moving away from the AI?
		if ball.direction.x < 0:
			if absf(paddle_center_y-half_screen_height) < 2:
				cpu_vel_y = 0
			elif paddle_center_y < half_screen_height:
				cpu_vel_y = CPU_PADDLE_VSPEED
			elif paddle_center_y > half_screen_height:
				cpu_vel_y = -CPU_PADDLE_VSPEED
			else:
				cpu_vel_y = 0
		else:
			var ball_center_y = ball.position.y + ball._half_height
			if absf(ball_center_y - paddle_center_y) < 2:
				cpu_vel_y = 0
			elif ball_center_y < paddle_center_y:
				cpu_vel_y = -CPU_PADDLE_VSPEED
			elif ball_center_y > paddle_center_y:
				cpu_vel_y = CPU_PADDLE_VSPEED
			else:
				cpu_vel_y = 0
		
		position.y += cpu_vel_y * delta


func get_center_y() -> float:
	return position.y + _half_height

func _on_area_entered(area: Area2D) -> void:
	var factor = 0
	if area.name == "Ball":
		var ball = area as Ball
		var velocity = ball.direction * ball.speed
		velocity.y = remap(ball.get_center_y()-get_center_y(),-_half_height,_half_height,-750,750)
		velocity.x = -velocity.x
		ball.direction = velocity.normalized()
		ball.speed = velocity.length()
		ball.accelerate()
		field_node.sfx_paddle.play()

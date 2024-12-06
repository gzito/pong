extends Area2D

enum BoundaryLocation { TOP, BOTTOM, LEFT, RIGHT }
@export var location : BoundaryLocation = BoundaryLocation.TOP
@onready var field_node = get_node("/root/Field")

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Ball":
		var ball = area as Ball
		if location == BoundaryLocation.TOP or location == BoundaryLocation.BOTTOM:
			ball.direction.y = -ball.direction.y
			field_node.sfx_bounce_edge.play()
		elif location == BoundaryLocation.LEFT or BoundaryLocation.RIGHT:
			ball.reset()
			if location == BoundaryLocation.LEFT:
				field_node.rightScore += 1
			elif location == BoundaryLocation.RIGHT:
				field_node.leftScore += 1
			field_node.updateScore()
			field_node.sfx_score.play()
			

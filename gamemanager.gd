extends Node2D

var leftScore: int = 0
var rightScore: int = 0
@onready var sfx_bounce_edge = $SfxBounceEdge
@onready var sfx_score = $SfxScore
@onready var sfx_paddle = $SfxPaddle
@onready var ball = $Ball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ball.reset()
	updateScore()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateScore() -> void:
	$LeftScore.text = str(leftScore)
	$RightScore.text = str(rightScore)

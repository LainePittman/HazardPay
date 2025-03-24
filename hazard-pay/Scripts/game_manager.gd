extends Node

var score = 0
var seconds_left
@onready var score_label: Label = $ScoreLabel
@onready var time_label: Label = $TimeLabel
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start()
	
func _process(delta: float) -> void:
	seconds_left = int(timer.time_left)
	time_label.text = "Time Remaining: " + str(seconds_left) + "s"

func add_point():
	score += 2
	score_label.text = "Current Paycheck: " + str(score) + "$"
	var temp_time = seconds_left + 5
	timer.start(temp_time)
	
func remove_point():
	score -= 1
	score_label.text = "Current Paycheck: " + str(score) + "$"

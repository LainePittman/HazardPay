extends Node2D

var is_closed: bool = false
var open_hand = load("res://Assets/hand/open_hand.png")
var closed_hand = load("res://Assets/hand/closed_hand.png")
var held_object = false
var score = 0
var knife = preload("res://Scenes/knife.tscn")
@onready var game_manager: Node = %GameManager
@onready var marker: Marker2D = $Marker2D


func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_clicked)

func _process(delta: float) -> void:
	if Input.is_action_pressed("openclose"):
		is_closed = true
		close_hand()
	else:
		is_closed = false
		Input.set_custom_mouse_cursor(open_hand, 0, Vector2(50, 50))

func close_hand():
	Input.set_custom_mouse_cursor(closed_hand, 0, Vector2(50, 50))
	

func _on_pickable_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object
		
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity() / 5.0)
			held_object = null


func _on_spawn_timer_timeout() -> void:
	for i in 3:
		var temp_knife = knife.instantiate()
		temp_knife.position = marker.global_position
		get_parent().add_child(temp_knife)
		for node in get_tree().get_nodes_in_group("pickable"):
			node.clicked.connect(_on_pickable_clicked)
		

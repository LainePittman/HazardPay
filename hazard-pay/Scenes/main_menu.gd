extends Control

var open_hand = load("res://Assets/hand/open_hand.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	print("Pressed Play")
	get_tree().change_scene_to_file("res://Scenes/test_scene.tscn")
	Input.set_custom_mouse_cursor(open_hand, 0, Vector2(50, 50))


func _on_controls_pressed() -> void:
	print("Pressed Controls")
	get_tree().change_scene_to_file("res://Scenes/controls_page.tscn")



func _on_quit_pressed() -> void:
	print("Pressed Quit")
	get_tree().quit()

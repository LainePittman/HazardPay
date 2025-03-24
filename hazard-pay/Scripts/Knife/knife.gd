extends RigidBody2D

signal clicked
signal sink
signal cleaner
var mode
var held = false
var is_clean: bool = false
@onready var texture: Sprite2D = $Sprite2D
@onready var  clean_texture = load("res://Assets/Knife/clean_knife.png")
@onready var clean_timer: Timer = $CleanProgress
@onready var game_manager: Node = %GameManager

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("clicked")
			clicked.emit(self)
			
func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	freeze = true
	held = true

func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false


func _on_clean_progress_timeout() -> void:
	texture.set_texture(clean_texture)
	is_clean = true


func _on_sink_water_area_entered(area: Area2D) -> void:
	clean_timer.start()
	print("Timer START")
	emit_signal("sink")


func _on_dish_reciever_area_entered(area: Area2D) -> void:
	if is_clean == true:
		queue_free()
		game_manager.add_point()

	else:
		game_manager.remove_point()
		queue_free()
	emit_signal("cleaner")

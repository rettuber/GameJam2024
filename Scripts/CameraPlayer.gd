extends Camera2D

@export var CAMERA_MOVEMENT_SPEED = 5
const ZOOM_INCREMENT = 0.05
const ZOOM_MIN = 0.5
const ZOOM_MAX = 5.0
var zoom_level := 1.0
var cameraMove = Vector2.ZERO

#func _process(delta: float) -> void:
#region Moving Camera Pan
#	var mousePos := (get_global_mouse_position() - global_position) * zoom_level
#	var screen: Vector2 = get_viewport().size
#	mousePos += screen / 2 #Normalize mouse position
	
#	if mousePos.x < screen.x / 5:
#		position.x -= CAMERA_MOVEMENT_SPEED
#	elif mousePos.x > screen.x - screen.x / 5:
#		position.x += CAMERA_MOVEMENT_SPEED
#	if mousePos.y < screen.y / 5:
#		position.y -= CAMERA_MOVEMENT_SPEED
#	elif mousePos.y > screen.y - screen.y / 5:
#		position.y += CAMERA_MOVEMENT_SPEED
#endregion

#func _input(event: InputEvent) -> void:
#region Zooming
#	var mousePos := get_global_mouse_position() - global_position
#	var screen: Vector2 = get_viewport().size
#	if event is InputEventMouseButton:
#		mousePos = get_global_mouse_position() - global_position + screen / 2
#		match event.button_index:
#			MOUSE_BUTTON_WHEEL_UP:
#				zoom_level = clamp(zoom_level + ZOOM_INCREMENT, ZOOM_MIN, ZOOM_MAX)
#			MOUSE_BUTTON_WHEEL_DOWN:
#				zoom_level = clamp(zoom_level - ZOOM_INCREMENT, ZOOM_MIN, ZOOM_MAX)
#		zoom = zoom.slerp(zoom_level * Vector2.ONE, 10 * get_process_delta_time())
#		position += mousePos - (get_global_mouse_position() - global_position + screen / 2)
#endregion

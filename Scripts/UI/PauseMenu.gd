extends Control

func _on_Resume_pressed() -> void:
	visible = false

func _on_Options_pressed() -> void:
	pass # Replace with function body.

func _on_ToMainMenu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scripts/UI/Main Menu.tscn")

func _on_Exit_pressed() -> void:
	get_tree().quit()

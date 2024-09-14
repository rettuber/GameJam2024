class_name CloudPopUp
extends Control

#@export var Icon : Texture2D
#@export var Modifier : Texture2D

func _ready() -> void:
	visible = false

#func activate_and_set_icon(icon: Texture2D) -> void :
#	set_icon(icon)
#	appear()

#func set_icon(icon: Texture2D) -> void :
#	$CloudImage/Icon.texture = icon

#func toggle_modifier() -> void:
#	$CloudImage/Modifier.visible = not($CloudImage/Modifier.visible)

func appear() -> void:
	visible = true

func disappear() -> void:
	visible = false

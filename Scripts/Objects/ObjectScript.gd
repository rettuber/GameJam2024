class_name InteractableObject
extends TextureButton

@export var Name: String = "Object" # Название объекта
@export var ColorBugged : Color = Color("e0a8ad")
@export var ColorUnusable : Color = Color ("a0a0a0")
@export var Actions : Array[ObjectAction] = []; # Массив действий
@export var Selected_Action: ObjectAction
enum State { USABLE, BUGGED, UNUSABLE } # Состояния
@export var state: State # Состояние

@export var InteractionTime: float = 5.0

@onready var popup = $CloudPopUp # Облачко поп-ап

# Что происходит при загрузке сцены?
func _ready() -> void:
	state = State.USABLE
	DeactivatePopUp()
	# Генерация кнопок
	for action in Actions:
		var button = Button.new()
		button.text = action.Name
		button.connect("pressed", Callable(self, action.player_function_name))
		$FlowContainer.add_child(button)
	$FlowContainer.visible = false

# Что происходит когда игрок взаимодействовал?
func Player_interaction() :
	self_modulate = ColorBugged
	disabled = true
	state = State.BUGGED
	$AudioStreamPlayer.play()
	$FlowContainer.visible = false

# Что происходит когда подходит НПС?
func NPC_interaction() :
	ActivatePopUp()
	await get_tree().create_timer(3.0).timeout
	$AudioStreamPlayer.stop()
	self_modulate = ColorUnusable
	state = State.UNUSABLE
	DeactivatePopUp()

# Функции для управления поп-апом
#region PopUp Management
func ActivatePopUp() :
#	popup.activate_and_set_icon(icon)
	popup.appear()
	
func DeactivatePopUp() :
	popup.disappear()

#func ActivateModifier() :
#	popup.toggle_modifier()
#endregion

#region Buttons Selection
func _on_pressed() -> void:
	$FlowContainer.visible = true

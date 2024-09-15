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
@onready var modifier = $Modifier

# Что происходит при загрузке сцены?
func _ready() -> void:
	state = State.USABLE
	DeactivatePopUp()
	$Modifier.visible = false
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
#	$AudioStreamPlayer.play()
	ActivateModifier()
	$FlowContainer.visible = false

func NPC_interact():
	ChangeIcon("res://Assets/UI/HUD/GearIcon.png")
	ActivatePopUp()
	await get_tree().create_timer(InteractionTime).timeout
	DeactivatePopUp()

# Что происходит когда подходит НПС?
func NPC_repair() :
	ChangeIcon("res://Assets/UI/HUD/ScrewIcon.png")
	ActivatePopUp()
	await get_tree().create_timer(3.0).timeout
	DeactivateModifier()
#	$AudioStreamPlayer.stop()
	self_modulate = ColorUnusable
	state = State.UNUSABLE
	DeactivatePopUp()

# Функции для управления поп-апом
#region PopUp Management
func ChangeIcon(icon: String) :
	var texture : Texture2D = load(icon) 
	$CloudPopUp/CloudImage/Icon.texture = texture
	
func ActivatePopUp() :
	$CloudPopUp.visible = true
	
func DeactivatePopUp() :
	$CloudPopUp.visible = false

func ActivateModifier() :
	$Modifier.visible = true
	$Modifier/AnimationPlayer.play("Sparks")

func DeactivateModifier() :
	$Modifier.visible = false
	$Modifier/AnimationPlayer.stop()
#endregion

#region Buttons Selection
func _on_pressed() -> void:
	$FlowContainer.visible = true

func _on_focus_exited() -> void:
	$FlowContainer.visible = false

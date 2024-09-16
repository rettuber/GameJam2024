extends InteractableObject

var turned_on = false
@export var texture_on : Texture2D
@export var texture_off : Texture2D

func generate_buttons():
	$FlowContainer/TurnOff.disabled = true

func Toggle(i: int):
	switcheroo()
	check_for_npc(i)

func NPC_interact():
	Toggle(-2)

func switcheroo():
	if turned_on:
		$FlowContainer/TurnOn.disabled = false
		$FlowContainer/TurnOff.disabled = true
		turned_on = false
		texture_normal = texture_off
		texture_pressed = texture_off
		texture_hover = texture_off
		texture_disabled = texture_off
	if not turned_on:
		$FlowContainer/TurnOn.disabled = true
		$FlowContainer/TurnOff.disabled = false
		turned_on = true
		texture_normal = texture_on
		texture_pressed = texture_on
		texture_hover = texture_on
		texture_disabled = texture_on

func check_for_npc(i):
	if i >= 0: # PLAYER DID IT
		Selected_Action = Actions[i]
		Interface.UpdateAISpeech(Selected_Action.Description)
		self_modulate = ColorBugged
		disabled = true
		state = State.BUGGED
#		$AudioStreamPlayer.play()
		ActivateModifier()
		$FlowContainer.visible = false
		interaction_over.emit(0)
	elif i == -1: # NPC IS REPAIRING
		self_modulate = ColorUnusable
		state = State.UNUSABLE
		ChangeIcon("res://Assets/UI/HUD/ScrewIcon.png")
		ActivatePopUp()
		await get_tree().create_timer(InteractionTime).timeout
		switcheroo()
		DeactivateModifier()
#		$AudioStreamPlayer.stop()
		DeactivatePopUp()
		interaction_over.emit(-1)
	elif i == -2: # NPC IS USING ITEM
		ChangeIcon("res://Assets/UI/HUD/GearIcon.png")
		ActivatePopUp()
		await get_tree().create_timer(InteractionTime).timeout
		DeactivatePopUp()
		interaction_over.emit(-2)

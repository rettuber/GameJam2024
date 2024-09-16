extends InteractableObject

var turned_on = false
signal turned_onnn

func generate_buttons():
	pass

func NPC_interact():
	Toggle(-2)

func Toggle(i: int) -> void:
	TurnOffOn()
	CheckForNPC(i)
	turned_onnn.emit()

func TurnOffOn():
	if turned_on:
		turned_on = false
	if not turned_on:
		turned_on = true

func CheckForNPC(i: int):
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
		TurnOffOn()
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

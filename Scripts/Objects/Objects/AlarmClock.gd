extends InteractableObject

func AlarmClockRing():
	Selected_Action = Actions[0]
	Interface.UpdateAISpeech(Selected_Action.Description)
	Player_interaction()
	
func AlarmClockTurnOff():
	Selected_Action = Actions[0]
	NPC_repair()

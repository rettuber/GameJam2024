extends CharacterBody2D

var StressLevel: float = 0.0
var movement_speed: float = 200.0
var current_target_position: Vector2 = Vector2(60.0,180.0)
var current_target : InteractableObject
@export var Destinations: Array[InteractableObject] = []
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
var movement_allowed = false
var i = 0

#region Actor Setup
func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	call_deferred("actor_setup")

func actor_setup():
	await get_tree().physics_frame
	current_target = Destinations[i]
	set_movement_target(current_target)
	movement_allowed = true
#endregion

#region Movement
func set_movement_target(target: InteractableObject):
	current_target = target
	current_target_position = current_target.global_position
	navigation_agent.target_position = current_target_position

func _physics_process(delta):
	if movement_allowed:
		if navigation_agent.is_navigation_finished():
			_attempt_interact()
			movement_allowed = false
			return
	
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
		velocity = current_agent_position.direction_to(next_path_position) * movement_speed
		move_and_slide()
#endregion

func _attempt_interact():
	if current_target.state == current_target.State.BUGGED:
	#	print("Human is angry!")
		Interface.IncreaseStress()
		draw_call(-1)
	if current_target.state == current_target.State.USABLE:
	#	print("Human is happy!")
		pass
	current_target.connect("interaction_over", interaction_over)

func interaction_over(flag: int) :
	if flag >= 0:
		Interface.IncreaseStress()
		draw_call(-1)
	if flag == -1:
		pass
	if flag == -2:
		Interface.DecreaseStress()
		draw_call(flag)
	current_target.interaction_over.disconnect(interaction_over)
	_continue_movement()

func draw_call(i: int) :
	var callable
	if not current_target.Selected_Action:
		current_target.NPC_interact()
	else:
		callable = current_target.Selected_Action.npc_function_name
		current_target.call(callable, i)

func _continue_movement():
	Interface.RandomAISPeech()
	i += 1
	if i >= Destinations.size():
		i = 0
	set_movement_target(Destinations[i])
	movement_allowed = true

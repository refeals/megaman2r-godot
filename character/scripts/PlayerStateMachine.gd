extends StateMachine

#var input_direction := Vector2()

onready var STATES = {
  "spawn": $Spawn,
  "idle": $Idle,
  "run": $Run,
  "jump": $Jump,
  "fall": $Fall,
  "slide": $Slide,
  "stagger": $Stagger,
#  "climb": $Climb,
#  "climb_shoot": $ClimbShoot,
  "death": $Death
}

func _ready() -> void:
  states_map = STATES

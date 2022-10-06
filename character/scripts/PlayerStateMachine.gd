extends StateMachine

#var input_direction := Vector2()

func _ready() -> void:
  states_map =  {
    "Spawn": $Spawn,
    "Idle": $Idle,
    "Run": $Run,
    "Jump": $Jump,
    "Fall": $Fall,
    "Slide": $Slide,
    "Stagger": $Stagger,
  #  "Climb": $Climb,
  #  "ClimbShoot": $ClimbShoot,
    "Death": $Death
  }

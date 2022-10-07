extends State

onready var timer = $IdleTimer

func enter(_msg := {}) -> void:
  owner.animatedSprite.set_animation("Idle")
  owner.animatedSprite.stop()

func handle_input(_event: InputEvent) -> void:
  return

func process(_delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")

  if x_input != 0:
    state_machine.change_state(state_machine.states_map.Run)
    return

  if Input.is_action_just_pressed("ui_jump"):
    state_machine.change_state(state_machine.states_map.Jump)
    return

  if !owner.is_on_floor():
    state_machine.change_state(state_machine.states_map.Fall)
    return

  if Input.is_action_just_pressed("ui_shoot"):
    print("shoot")
    return

  if Input.is_action_just_pressed("ui_slide") or (Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_jump")):
    state_machine.change_state(state_machine.states_map.Slide)
    return

func physics_process(delta: float) -> void:
  owner.motion.x = lerp(owner.motion.x, 0, owner.FRICTION * delta)
  return

func exit() -> void:
#  timer.stop()
  return

#func run_timer():
#  timer.wait_time = randi() % 4 + 2 # between 2 and 6
#  timer.start()

#func _on_Timer_timeout() -> void:
#  print(owner.stateMachine.STATES)
#  owner.animatedSprite.play("Idle")
#  run_timer()
#
#func _on_AnimatedSprite_animation_finished() -> void:
#  owner.animatedSprite.set_frame(0)
#  owner.animatedSprite.stop()

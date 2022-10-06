extends State

onready var timer = $Timer

func enter(_msg := {}) -> void:
  owner.animatedSprite.set_animation("Idle")
  owner.animatedSprite.stop()

func handle_input(_event: InputEvent) -> void:
  return

func process(_delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")

  if x_input != 0:
    state_machine.change_state("Run")

  elif Input.is_action_pressed("ui_jump"):
    state_machine.change_state("Jump")

  elif !owner.is_on_floor():
    state_machine.change_state("Fall")
  return

func physics_process(delta: float) -> void:
  owner.applyGravity(delta)
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

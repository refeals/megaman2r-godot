extends State

onready var timer := $IdleTimer
onready var player: PlayerPhysics = $"../.."

func enter(_msg := {}) -> void:
  player.animatedSprite.set_animation("Idle")
  player.animatedSprite.stop()

func handle_input(_event: InputEvent) -> void:
  return

func process(_delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")

  if x_input != 0:
    state_machine.change_state(state_machine.states_map.Run, { "shouldRun": false })
    return

  if Input.is_action_just_pressed("ui_slide") or (Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_jump")):
    state_machine.change_state(state_machine.states_map.Slide)
    return

  if Input.is_action_just_pressed("ui_jump"):
    state_machine.change_state(state_machine.states_map.Jump)
    return

  if !player.is_on_floor():
    state_machine.change_state(state_machine.states_map.Fall)
    return

  if Input.is_action_just_pressed("ui_shoot"):
    player.emit_signal("shoot")
    return

func physics_process(delta: float) -> void:
  player.motion.x = lerp(player.motion.x, 0, player.FRICTION * delta)
  return

func exit() -> void:
#  timer.stop()
  return

#func run_timer():
#  timer.wait_time = randi() % 4 + 2 # between 2 and 6
#  timer.start()

#func _on_Timer_timeout() -> void:
#  print(player.stateMachine.STATES)
#  player.animatedSprite.play("Idle")
#  run_timer()
#
#func _on_AnimatedSprite_animation_finished() -> void:
#  player.animatedSprite.set_frame(0)
#  player.animatedSprite.stop()

func _on_Player_shoot() -> void:
  player.shootWeapon()
  player.animatedSprite.play("Shoot")
  player.shootAnimTimer.start(player.SHOOT_TIMER)

func _on_ShootAnimTimer_timeout() -> void:
  player.animatedSprite.play("Idle")

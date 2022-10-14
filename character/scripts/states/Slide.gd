extends State

onready var timer = $SlideTimer

func enter(_msg := {}) -> void:
  owner.animatedSprite.play("Slide")
#  owner.collisionShape2D.scale.y = 0.7
#  owner.collisionShape2D.position.y = -7
  timer.start(owner.SLIDE_TIMER)

func handle_input(_event: InputEvent) -> void:
  return

func process(_delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")
  var isNotCollidingAbove = !owner.slideRaycastLeft.is_colliding() and !owner.slideRaycastRight.is_colliding()
  var direction = -1 if owner.animatedSprite.flip_h else 1

  if not owner.is_on_floor():
    state_machine.change_state(state_machine.states_map.Idle)
    return

  if Input.is_action_just_pressed("ui_jump") and not Input.is_action_pressed("ui_down"):
    if isNotCollidingAbove:
      state_machine.change_state(state_machine.states_map.Jump)
      return

  if owner.is_on_wall():
    if isNotCollidingAbove:
      state_machine.change_state(state_machine.states_map.Idle)
      return

  if x_input != 0 and x_input != direction:
    if isNotCollidingAbove:
      state_machine.change_state(state_machine.states_map.Run, { "shouldRun": true })
      return
    else:
      direction = x_input
      owner.animatedSprite.flip_h = direction != 1
      return

  if timer.is_stopped() and isNotCollidingAbove:
    state_machine.change_state(state_machine.states_map.Idle)
    return

func physics_process(_delta: float) -> void:
  var direction = -1 if owner.animatedSprite.flip_h else 1

  owner.motion.x += direction * owner.SLIDE_ACCELERATION * owner.TARGET_FPS

  if direction == -1:
    owner.motion.x = clamp(owner.motion.x, -owner.SLIDE_SPEED, 0)
  else:
    owner.motion.x = clamp(owner.motion.x, 0, owner.SLIDE_SPEED)

#  owner.motion.y = 1

#  owner.applyGravity(delta)

  owner.motion = owner.move_and_slide(owner.motion)

func exit() -> void:
#  owner.collisionShape2D.scale.y = 1
#  owner.collisionShape2D.position.y = -10
  timer.stop()

func _on_SlideTimer_timeout() -> void:
  var isNotCollidingAbove = !owner.slideRaycastLeft.is_colliding() and !owner.slideRaycastRight.is_colliding()

  if isNotCollidingAbove:
    state_machine.change_state(state_machine.states_map.Idle)

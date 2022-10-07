extends State

func enter(_msg := {}) -> void:
  owner.animatedSprite.play("Run")

func handle_input(_event: InputEvent) -> void:
  return

func process(_delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")

  if x_input == 0:
    state_machine.change_state(state_machine.states_map.Idle)
    return

  if Input.is_action_just_pressed("ui_jump"):
    state_machine.change_state(state_machine.states_map.Jump)
    return

  if not owner.is_on_floor():
    state_machine.change_state(state_machine.states_map.Fall)
    return

  if Input.is_action_just_pressed("ui_shoot"):
    print("shoot")
    return

  if Input.is_action_just_pressed("ui_slide") or (Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_jump")):
    state_machine.change_state(state_machine.states_map.Slide)
    return

func physics_process(delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")

  if x_input != 0:
    owner.animatedSprite.flip_h = x_input < 0

  owner.motion.x += x_input * owner.ACCELERATION * owner.TARGET_FPS

  if x_input > 0:
    owner.motion.x = clamp(owner.motion.x, 0, owner.MAX_SPEED)
  elif x_input < 0:
    owner.motion.x = clamp(owner.motion.x, -owner.MAX_SPEED, 0)

  # movement specific code
  if x_input == 0:
    owner.motion.x = lerp(owner.motion.x, 0, owner.FRICTION * delta)

  owner.motion = owner.move_and_slide(owner.motion, Vector2.UP)

  # movement agnostic code (works on floor or not)
#  var ladder = owner.isCollidingWithLadder()
#  if ladder:
#    if y_input < 0 or (y_input > 0 and !owner.is_on_floor()):
#      owner.motion = Vector2.ZERO
#      owner.position.x = ladder.position.x + 8
#      return "ladder"

func exit() -> void:
  return

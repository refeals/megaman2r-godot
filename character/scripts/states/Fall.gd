extends State

func enter() -> void:
  owner.animatedSprite.play("Fall")

func handle_input(event: InputEvent) -> void:
  return

func process(delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")
  
  if owner.is_on_floor():
    if x_input == 0:
      state_machine.change_state("Idle")
    else:
      state_machine.change_state("Run")
  
func physics_process(delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")
  var y_input = Input.get_axis("ui_up", "ui_down")
  var host = owner
  
  if x_input != 0:
    owner.animatedSprite.flip_h = x_input < 0
  
  owner.motion.x += x_input * owner.ACCELERATION * delta * owner.TARGET_FPS

  if x_input > 0:
    owner.motion.x = clamp(host.motion.x, 0, host.MAX_SPEED)
  elif x_input < 0:
    owner.motion.x = clamp(host.motion.x, -host.MAX_SPEED, 0)

  host.applyGravity(delta)

  if Input.is_action_just_released("ui_jump") and host.motion.y < 0:
    host.motion.y = -25

  if x_input == 0:
    host.motion.x = lerp(host.motion.x, 0, host.FRICTION * delta)

  # movement agnostic code (works on floor or not)
#  var ladder = host.isCollidingWithLadder()
#  if ladder:
#    if y_input < 0 or (y_input > 0 and !host.is_on_floor()):
#      host.motion = Vector2.ZERO
#      host.position.x = ladder.position.x + 8
#      return "ladder"

  host.motion = host.move_and_slide(host.motion, Vector2.UP)

func exit() -> void:
  return

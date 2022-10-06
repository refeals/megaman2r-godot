extends State

func enter() -> void:
  owner.animatedSprite.play("Run")

func handle_input(event: InputEvent) -> void:
  return

func process(delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")
  
  if x_input == 0:
    state_machine.change_state("Idle")

  if Input.is_action_pressed("ui_jump"):
    state_machine.change_state("Jump")

  elif !owner.is_on_floor():
    state_machine.change_state("Fall")
    
#  elif Input.is_action_just_pressed("ui_shoot"):
#    print("shoot")

#  elif Input.is_action_just_pressed("ui_slide") or (Input.is_action_pressed("ui_down") and Input.is_action_just_pressed("ui_jump")):
#    state_machine.change_state("Slide")
  
func physics_process(delta: float) -> void:
  var x_input = Input.get_axis("ui_left", "ui_right")
  var y_input = Input.get_axis("ui_up", "ui_down")

  if x_input != 0:
    owner.animatedSprite.flip_h = x_input < 0
    
  owner.motion.x += x_input * owner.ACCELERATION * delta * owner.TARGET_FPS

  if x_input > 0:
    owner.motion.x = clamp(owner.motion.x, 0, owner.MAX_SPEED)
  elif x_input < 0:
    owner.motion.x = clamp(owner.motion.x, -owner.MAX_SPEED, 0)

  # movement specific code
  if x_input == 0:
    owner.motion.x = lerp(owner.motion.x, 0, owner.FRICTION * delta)
  
  owner.applyGravity(delta)

  owner.motion = owner.move_and_slide(owner.motion, Vector2.UP)
  
  # movement agnostic code (works on floor or not)
#  var ladder = host.isCollidingWithLadder()
#  if ladder:
#    if y_input < 0 or (y_input > 0 and !host.is_on_floor()):
#      host.motion = Vector2.ZERO
#      host.position.x = ladder.position.x + 8
#      return "ladder"


func exit() -> void:
  return

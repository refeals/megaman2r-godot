extends KinematicBody2D

var motion = Vector2()
var direction: int
var player

const TARGET_FPS = 60

const ACCELERATION = 20
const MAX_SPEED = 250

func _ready() -> void:
  position = player.shootPosition.global_position
  get_node("VisibilityNotifier2D").connect("screen_exited", self, "_on_screen_exited")

func _physics_process(_delta: float) -> void:
  motion.x += direction * ACCELERATION * TARGET_FPS
  motion.x = clamp(motion.x, 0, MAX_SPEED)
  motion = move_and_slide(motion, Vector2.UP)

func _on_screen_exited() -> void:
  queue_free()

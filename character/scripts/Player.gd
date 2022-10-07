extends KinematicBody2D
class_name PlayerPhysics

const TARGET_FPS = 60

const ACCELERATION = 12
const MAX_SPEED = 80
const FRICTION = 30

const GRAVITY = 10
const JUMP_FORCE = 210

const SLIDE_ACCELERATION = 100
const SLIDE_SPEED = 180
const SLIDE_TIMER = 0.43

const LADDER_TIMER = 0.25
const LADDER_SPEED = 80

var motion = Vector2.ZERO

var currentSlideTimer = 0
var currentShootTimer = 0
var ladderAnimationTimer = 0

onready var animatedSprite := $AnimatedSprite
onready var collisionShape2D := $CollisionShape2D
onready var slideRaycastLeft := $SlideRaycastLeft
onready var slideRaycastRight := $SlideRaycastRight
onready var floorRaycast := $FloorRaycast

func _physics_process(_delta: float) -> void:
  return

func applyGravity():
  motion.y += GRAVITY

func is_on_floor():
  return floorRaycast.is_colliding()

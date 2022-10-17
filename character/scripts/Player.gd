extends KinematicBody2D
class_name PlayerPhysics

signal shoot

const TARGET_FPS = 60

const ACCELERATION = 12
const MAX_SPEED = 80
const FRICTION = 30

const GRAVITY = 10
const JUMP_FORCE = 210

const SLIDE_ACCELERATION = 100
const SLIDE_SPEED = 180
const SLIDE_TIMER = 0.43

const MAX_SHOTS = 3
const SHOOT_TIMER = 0.4

const LADDER_TIMER = 0.25
const LADDER_SPEED = 80

var motion = Vector2.ZERO

var currentShootTimer = 0
var ladderAnimationTimer = 0

var isShooting := false
var numOfShots := 0

onready var animatedSprite := $AnimatedSprite
onready var collisionShape2D := $CollisionShape2D
onready var slideRaycastLeft := $SlideRaycastLeft
onready var slideRaycastRight := $SlideRaycastRight
onready var floorRaycast := $FloorRaycast
onready var shootPosition := $ShootPosition
onready var shootAnimTimer := $ShootAnimTimer

var buster1 = preload("res://weapons/Buster1/Buster1.tscn")

func _physics_process(_delta: float) -> void:
  return

func applyGravity():
  motion.y += GRAVITY

func is_on_floor():
  return floorRaycast.is_colliding()

func shootWeapon():
  if numOfShots < MAX_SHOTS:
    var direction = -1 if animatedSprite.flip_h else 1
    var instance = buster1.instance()
    instance.direction = direction
    instance.player = self
    owner.add_child(instance)
    numOfShots += 1

func justToRemoveWarning():
  # unused: removes warning of unused signal
  emit_signal("shoot")

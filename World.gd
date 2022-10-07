extends Node2D

func _ready() -> void:
  $FlashFull.queue_free()
  randomize()

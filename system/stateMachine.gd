# Based on Nathan Lovato's tutorial:
# https://github.com/GDquest/Godot-engine-tutorial-demos/blob/master/2018/04-24-finite-state-machine/player_v2/state_machine.gd

extends Node

class_name StateMachine

var states_map := {}
#var states_stack := []
#var active := false setget set_active

signal state_changed(current_state)

export(NodePath) var initial_state: NodePath

onready var current_state: State = get_node(initial_state)
var previous_state: State = null

func _ready() -> void:
  yield(owner, "ready")
  for child in get_children():
    child.state_machine = self
  
  current_state.enter()
#    child.connect("finished", self, "_change_state")

func _unhandled_input(event: InputEvent) -> void:
  current_state.handle_input(event)
  
func _process(delta: float) -> void:
  current_state.process(delta)
  
func _physics_process(delta: float) -> void:
  current_state.physics_process(delta)
  
func change_state(target_state_name: String, msg := {}):
  if not has_node(target_state_name):
    return
  
  current_state.exit()
  previous_state = current_state
  current_state = get_node(target_state_name)
  current_state.enter()
  emit_signal("state_changed", current_state.name)
  print(previous_state.name, " -> ", current_state.name)

#func initialize(state: NodePath) -> void:
#  set_active(true)
#  states_stack = []
#  states_stack.push_front(get_node(state))
#  current_state = states_stack[0]
#  current_state._enter()

#func set_active(value: bool) -> void:
#  active = value
#  set_physics_process(value)
#  set_process_input(value)
#  if not active:
#    states_stack = []
#    current_state = null
#
#func _unhandled_input(event: InputEvent) -> void:
#    if current_state:
#        current_state._handle_input(event)
#
#func _physics_process(delta: float) -> void:
#    current_state._update(delta)
#
#func _on_animation_finished(anim_name: String) -> void:
#    if active:
#        current_state._on_animation_finished(anim_name)
#
#func _change_state(state_name: String) -> void:
#    if not active:
#        return
#
#    current_state._exit()
#
#    states_stack[0] = states_map[state_name]
#
#    current_state = states_stack[0]
#    emit_signal("state_changed", current_state)
#
#    current_state._enter()

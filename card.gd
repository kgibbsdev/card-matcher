extends Area2D

class_name Card

@onready var number_sprite_1 = $Number1
@onready var number_sprite_2 = $Number2
@onready var number_sprite_3 = $Number3
@onready var number_sprite_4 = $Number4
@onready var number_sprite_5 = $Number5
@onready var number_sprite_6 = $Number6
@onready var number_sprite_7 = $Number7
@onready var number_sprite_8 = $Number8
@onready var number_sprite_9 = $Number9

@export var number: int
var solved = false

signal card_picked(card)

func _ready():
	pass

func set_number(value): 
	number = value
	#print("set number to " + str(number))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouse and event.is_action_pressed("left_click"):
		set_card_pickable(false)
		show_number()
		card_picked.emit(self)

func hide_all_numbers():
	number_sprite_1.set_visible(false)
	number_sprite_2.set_visible(false)
	number_sprite_3.set_visible(false)
	number_sprite_4.set_visible(false)
	number_sprite_5.set_visible(false)
	number_sprite_6.set_visible(false)
	number_sprite_7.set_visible(false)
	number_sprite_8.set_visible(false)
	number_sprite_9.set_visible(false)

func show_number():
	match number:
		1: number_sprite_1.set_visible(true)
		2: number_sprite_2.set_visible(true)
		3: number_sprite_3.set_visible(true)
		4: number_sprite_4.set_visible(true)
		5: number_sprite_5.set_visible(true)
		6: number_sprite_6.set_visible(true)
		7: number_sprite_7.set_visible(true)
		8: number_sprite_8.set_visible(true)
		9: number_sprite_9.set_visible(true)

func set_solved(value):
	solved = value
	if solved == true:
		visible = false
	
func get_number():
	return number

func reset():
	hide_all_numbers()
	set_card_pickable(true)
	#set_disabled(false)

func set_card_pickable(value):
	self.input_pickable = value
	#$CollisionShape2D.set_disabled(value)

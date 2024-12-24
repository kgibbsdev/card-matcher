extends Node2D

var first_pick = null
var second_pick = null
var cards: Array[Node]
var numbers: Array[int]
var starting_position = Vector2(0, 0)
var card_scene = load("res://card.tscn")
@export var rows = 3
@export var columns = 4
@export var matches = 2
var x_offset = 100
var y_offset = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pick_numbers(rows * columns)
	spawn_cards(3, 4)
	cards = get_tree().get_nodes_in_group("cards")
	
func on_card_card_picked(card):
	pick(card)
	
func pick(card):
	if first_pick == null:
		first_pick = card
		first_pick.add_to_group("picked_card")
	elif first_pick != null and second_pick == null:
		second_pick = card
		second_pick.add_to_group("picked_card")
		print("used all picks")
		print(first_pick.number, second_pick.number)
		
		disable_cards_that_have_not_been_picked()
		$Timer.start()
		await $Timer.timeout
		
		resolve_picks()
		reset_picks()
		enable_cards()
		
func resolve_picks():
	if first_pick.number == second_pick.number:
		first_pick.set_solved(true)
		second_pick.set_solved(true)
		print(":)")
		
func reset_picks():
	first_pick.reset()
	second_pick.reset()
	first_pick.remove_from_group("picked_card")
	first_pick.remove_from_group("picked_card")
	first_pick = null
	second_pick = null
	
func disable_cards_that_have_not_been_picked():
	get_tree().call_group("cards", "set_card_pickable", false)

func enable_cards():
	get_tree().call_group("cards", "set_card_pickable", true)

func spawn_cards(rows, columns):
	#	spawn enough cards and also ensure that they are spawned in pairs
	for i in rows:
		for j in columns:
			var card = card_scene.instantiate()
			var number = numbers.pick_random()
			numbers.erase(number)
			card.set_number(number)
			card.position.x = starting_position.x + (i * 175) + x_offset
			card.position.y = starting_position.y + (j * 150) + y_offset
			card.global_position = card.position
			card.card_picked.connect(on_card_card_picked)
			card.add_to_group("cards")
			cards.append(card)
			spawn_card(card)
			
func spawn_card(card):
	add_child(card)

func pick_numbers(number_of_numbers):
	if number_of_numbers % matches != 0:
		print("Incorrect number of numbers!!!!")
	for i in number_of_numbers/matches:
		var chosen_number = randi_range(1, 9)
		for j in matches:
			numbers.append(chosen_number)

extends Node

# Constants
const MAX_RECIPE_ITEMS = 7

# class member variables
var Recipe = []
var Ingredients = ["Chicken", "Egg", "Mushroom", "Carrot"]

# Custom Methods
func DetermineRecipe():
	# Determines the ingredients for the recipe to be displayed on the TV
	# TODO: Fix behavior where it won't include one of each ingredient
	
	var IngredientsIndexMap = MAX_RECIPE_ITEMS
	for i in range(0, IngredientsIndexMap):
		var Ingredient = range(4)[randi()%range(4).size()]
		print("Ingredient Index is: " + str(Ingredient))
		Recipe.push_back(Ingredients[Ingredient])
		print("Ingredient selected is: " + Ingredients[Ingredient])

func DisplayRecipe():
	# TODO
	
	# Update the Sprites displayed on the TV to match the Recipe
	

# Native Godot Methods
func _ready():
	randomize()
	
	# Called every time the node is added to the scene.
	# Initialization here
	DetermineRecipe()

func _on_Chicken_input_event( viewport, event, shape_idx ):
	pass # replace with function body


func _on_Egg_input_event( viewport, event, shape_idx ):
	pass # replace with function body


func _on_Mushroom_input_event( viewport, event, shape_idx ):
	pass # replace with function body


func _on_Carrot_input_event( viewport, event, shape_idx ):
	pass # replace with function body

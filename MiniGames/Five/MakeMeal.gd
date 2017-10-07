extends Node

# Constants
const MAX_RECIPE_ITEMS = 7

# class member variables
var Recipe = []
var Ingredients = ["Chicken", "Egg", "Mushroom", "Carrot"]
var ChickenSpriteRef = preload("res://MiniGames/Five/ChickenSprite.tres")
var EggSpriteRef = preload("res://MiniGames/Five/EggSprite.tres")
var MushroomSpriteRef = preload("res://MiniGames/Five/MushroomSprite.tres")
var CarrotSpriteRef = preload("res://MiniGames/Five/CarrotSprite.tres")
var Meal = []

# Custom Methods
func DetermineRecipe():
	# Determines the ingredients for the recipe to be displayed on the TV
	
	var IngredientsIndexMap = MAX_RECIPE_ITEMS
	for i in range(0, IngredientsIndexMap):
		var Ingredient = range(4)[randi()%range(4).size()]
		#print("Ingredient Index is: " + str(Ingredient))
		Recipe.push_back(Ingredients[Ingredient])
		print("Ingredient selected is: " + Ingredients[Ingredient])

func DisplayRecipe():
	var index = 1
	# Update the Sprites displayed on the TV to match the Recipe
	for i in Recipe:
		if i == "Chicken":
			get_node("RecipeWrapper/Ingredient"+str(index)).set_texture(ChickenSpriteRef)
		elif i == "Egg":
			get_node("RecipeWrapper/Ingredient"+str(index)).set_texture(EggSpriteRef)
		elif i == "Mushroom":
			get_node("RecipeWrapper/Ingredient"+str(index)).set_texture(MushroomSpriteRef)
		elif i == "Carrot":
			get_node("RecipeWrapper/Ingredient"+str(index)).set_texture(CarrotSpriteRef)
		index = index + 1
	
func DetermineRecipeAdherence():
	# Determines if the complete meal coheres to the recipe
	# TODO Lock out the Selection Options
	
	
	#print("Comparison result: " + str(result))
	
	if Recipe == Meal:
		# Victory Condition
		print("Dinner is served!")
		get_node("VictoryPanel").show();
	else:
		# Defeat Condition
		print("Dinner is ruined!")
		get_node("DefeatPanel").show();

func CheckIfSolutionIsReady():
	# Checks to see if the completed recipe has seven ingredients
	if Meal.size() == 7:
		DetermineRecipeAdherence()
	else:
		print("All seven ingredients not added")
	
# Native Godot Methods
func _ready():
	randomize()
	
	# Called every time the node is added to the scene.
	# Initialization here
	DetermineRecipe()
	DisplayRecipe()

func _on_Chicken_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Chicken Clicked")
		Meal.push_back("Chicken")
		CheckIfSolutionIsReady()

func _on_Egg_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Egg Clicked")
		Meal.push_back("Egg")
		CheckIfSolutionIsReady()

func _on_Mushroom_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Mushroom Clicked")
		Meal.push_back("Mushroom")
		CheckIfSolutionIsReady()

func _on_Carrot_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Carrot Clicked")
		Meal.push_back("Carrot")
		CheckIfSolutionIsReady()

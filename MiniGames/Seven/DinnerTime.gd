extends Node2D

onready var GlobalNode = get_node("/root/gloal")
var WrongSelections = 0
var QuestionsMaryJane = [
	"You look a bit nervous. Are you okay?", 
	"How was your day?",
	"What interests you?",
	"What are your dreams?",
	"I just noticed this, but why is your skin blue?",
	"Are you sure you're not human? It's totally fine if you aren't.",
	"So what is your species hoping to accomplish here?"
]
var QuestionsAmilia = [

]
# Correct answers have a C in their Identifier
var Answers = [
	{ 
		"A":"I'm a bit nervous",
		"B":"No, not at all" 
	},
	{
		"A":"It was good. I spent it making this dinner!",
		"B":"It could have been better."
	},
	{
		"A":"I really like listening to strange music and eating eels.",
		"B":"I'm really passionate about communication."
	},
	{
		"A":"I dream about ponies. And narwhals",
		"B":"I've always dreamed about helping bridge cultures."
	},
	{
		"A":"What are you talking about? My skin's not blue! Look at my nose!!",
		"B":"I have a skin disorder, something about lack of carbon..."
	},
	{
		"A":"I'm positive i'm human. I listen to human music and read human books! Fellow...er...human...",
		"B":"Okay, you got me. I am an alien. I'm here to explore your culture."
	},
	{
		"A":"I'm here to conduct research, but I believe where our paths intersect, we can have a significant impact on the universe.",
		"B":"Well, the Earth is blocking off our view of the nebula and we need to ge-Does this matter?"
	}
]
var CorrectAnswers = ["B", "A", "B", "B", "A", "B", "A"]
var SelectedDate
var ActiveQuestion

# Custom Methods

func SelectDate():
	#var SelectedDate = GlobalNode.mate_selected
	
	#if SelectedDate == AMILIA:
	#	print("You're on a date with Amilia")
	#	get_node("MaryJaneOverlay").show()
	#elif SelectedDate == MARYJANE:
	#	print("You're on a date with Mary Jane")
	#	get_node("AmiliaOverlay").show()
	SelectedDate = "Mary Jane"
	get_node("MaryJaneOverlay").show()

func CheckWrongSelections():
	# Checks to see if the wrong selections has hit 3. If so, returns state to indicate game over
	if WrongSelections == 3:
		print("Game over")
	else:
		print("still in the game")

func LoadQAndA(QNumber):
	# Load the active question
	get_node("Conversation/DateQuestion").set_text(QuestionsMaryJane[(ActiveQuestion-1)])
	get_node("Conversation/Answer1").set_text(Answers[(ActiveQuestion-1)].A)
	get_node("Conversation/Answer2").set_text(Answers[(ActiveQuestion-1)].B)

func SelectedWrong():
	# Increases the wrong selections by 1
	WrongSelections = WrongSelections + 1
	if WrongSelections == 1:
		get_node("WrongAnswers/A1").show();
		
	if WrongSelections == 2:
		get_node("WrongAnswers/A2").show();
		
	if WrongSelections == 3:
		get_node("WrongAnswers/A3").show();

func CheckAnswer1(Response):
	if Response == CorrectAnswers[(ActiveQuestion-1)]:
		# Is still a valid answer, continue the conversation
		print("Correct answer")
	else:
		WrongSelections = WrongSelections + 1
		SelectedWrong()
	
func CheckAnswer2(Response):
	pass

# Native Godot Methods

func _ready():
	randomize()
	ActiveQuestion = 1
	SelectDate()
	LoadQAndA(ActiveQuestion)

func _on_Answer1_button_down():
	var result = CheckAnswer1("A")
	#TODO Calculate the result for Answer 1
	ActiveQuestion = ActiveQuestion + 1
	LoadQAndA(ActiveQuestion)

func _on_Answer2_button_down():
	var result = CheckAnswer2("B")
	#TODO Calculate the result for Answer 1
	ActiveQuestion = ActiveQuestion + 1
	LoadQAndA(ActiveQuestion)

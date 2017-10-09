extends Node2D

export(String, FILE, "*.tscn") var next_scene = "res://Credits.tscn"
var change_scene = null
var WrongSelections = 0
var QuestionsMaryJane = [
	"You look a bit nervous. Are you okay?", 
	"How was your day?",
	"What interests you?",
	"What are your dreams?",
	"So... why is your skin blue?",
	"Are you sure you're not human?",
	"So what is your plans for tonight?"
]
var QuestionsAmilia = [
	"Do you watch movies?", 
	"Do you get out much?",
	"What your favorite past time?",
	"That's interesting, is it true?",
	"Huh, Why would you do that?",
	"Would you like to do that together?",
	"When can we start?"
]
# Correct answers have a C in their Identifier
var MaryJaneAnswers = [
	{ 
		"A":"I'm a bit nervous",
		"B":"No, not at all" 
	},
	{
		"A":"It was good. I spent it making this dinner!",
		"B":"It could have been better."
	},
	{
		"A":"I like listening to strange music and eating eels.",
		"B":"I'm really passionate about communication."
	},
	{
		"A":"I dream about ponies. And narwhals",
		"B":"I've always dreamed about helping bridge cultures."
	},
	{
		"A":"What are you talking about? My skin's not blue!",
		"B":"I have a skin disorder, lack of carbon..."
	},
	{
		"A":"I'm positive i'm human. I listen to human music.",
		"B":"Okay, you got me. I am an alien. "
	},
	{
		"A":"I think I will be here for a long time",
		"B":"Earth is blocking off our view of the nebula"
	}
]
var AmiliaAnswers = [
	{ 
		"A":"I love movies!",
		"B":"Who has time for that?" 
	},
	{
		"A":"No, I'm kind of a shut in",
		"B":"I'm usually at the gym"
	},
	{
		"A":"Taking care of kids",
		"B":"Taking things apart"
	},
	{
		"A":"Nah, I lie a lot",
		"B":"Of course!"
	},
	{
		"A":"Bored",
		"B":"Doesn't everyone do that?"
	},
	{
		"A":"Yes!  That would be great!",
		"B":"Uhm, ok.  Why not"
	},
	{
		"A":"Let's do this",
		"B":"Maybe some other time"
	}
]
var MaryJaneCorrectAnswers = ["B", "A", "B", "B", "A", "B", "A"]
var AmiliaCorrectAnswers = ["B", "A", "B", "B", "A", "B", "A"]
var SelectedDate
var ActiveQuestion
var questions = null
var answers = null
var correct_answers = null

# Custom Methods

func SelectDate():
	var SelectedDate = global.mate_selected
	if SelectedDate == global.AMILIA:
		print("You're on a date with Amilia")
		get_node("MaryJaneOverlay").show()
		questions = QuestionsMaryJane
		answers = MaryJaneAnswers
		correct_answers = MaryJaneCorrectAnswers
	elif SelectedDate == global.MARYJANE:
		print("You're on a date with Mary Jane")
		get_node("AmiliaOverlay").show()
		questions = QuestionsAmilia
		answers = AmiliaAnswers
		correct_answers = AmiliaCorrectAnswers
	else:
		SelectedDate = global.MARYJANE
		get_node("MaryJaneOverlay").show()
		questions = QuestionsMaryJane
		answers = MaryJaneAnswers
		correct_answers = MaryJaneCorrectAnswers

func CheckWrongSelections():
	# Checks to see if the wrong selections has hit 3. If so, returns state to indicate game over
	if WrongSelections == 3:
		print("Game over")
		get_node("DefeatPanel").show()
		get_node("Conversation/Answer1").set_disabled(true)
		get_node("Conversation/Answer2").set_disabled(true)
		change_scene = "res://MiniGames/Seven/Intro.tscn"
	else:
		print("still in the game")
		get_node("VictoryPanel").show()
		get_node("Conversation/Answer1").set_disabled(true)
		get_node("Conversation/Answer2").set_disabled(true)
		change_scene = next_scene

func LoadQAndA(QNumber):
	# Load the active question
	if ActiveQuestion -1 >= questions.size():
		CheckWrongSelections()
	else:
		get_node("Conversation/DateQuestion").set_text(questions[(ActiveQuestion-1)])
		get_node("Conversation/Answer1").set_text(answers[(ActiveQuestion-1)].A)
		get_node("Conversation/Answer2").set_text(answers[(ActiveQuestion-1)].B)

func SelectedWrong():
	# Increases the wrong selections by 1
	WrongSelections += 1
	if WrongSelections == 1:
		get_node("WrongAnswers/A1").show();
		
	if WrongSelections == 2:
		get_node("WrongAnswers/A2").show();
		
	if WrongSelections == 3:
		get_node("WrongAnswers/A3").show();
		CheckWrongSelections()

func CheckAnswer1(Response):
	if Response == correct_answers[(ActiveQuestion-1)]:
		# Is still a valid answer, continue the conversation
		print("Correct answer")
	else:
		print("Wrong answer")
		SelectedWrong()


# Native Godot Methods
func _input(event):
	if not change_scene == null:
		if((event.type == InputEvent.KEY) or (event.type == InputEvent.MOUSE_BUTTON) and event.pressed):
			global.goto_scene(change_scene)

func _ready():
	randomize()
	ActiveQuestion = 1
	SelectDate()
	LoadQAndA(ActiveQuestion)
	set_process_input(true)

func _on_Answer1_button_down():
	var result = CheckAnswer1("A")
	#TODO Calculate the result for Answer 1
	ActiveQuestion = ActiveQuestion + 1
	LoadQAndA(ActiveQuestion)

func _on_Answer2_button_down():
	var result = CheckAnswer1("B")
	#TODO Calculate the result for Answer 1
	ActiveQuestion = ActiveQuestion + 1
	LoadQAndA(ActiveQuestion)

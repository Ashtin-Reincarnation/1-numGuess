extends Control

var regex = RegEx.new()
var old_text=""
var ans=0
var random = RandomNumberGenerator.new()
var playState
var logColor = Color(0.224,0.705,0.224)
var logOutlineColor = Color(0.224,0.705,0.224,0.224)
var logMessage = ""
var gameState=true

# Called when the node enters the scene tree for the first time.
func _ready():
	regex.compile("^[0-9]*$")
	$logMessage.text=""
	playState=true
	ans = random.randi_range(1,100)
	print(ans)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func submit(input):
	if regex.search(input):
		
		check(input as int)
		old_text=str(input)
	else:
		logOutlineColor = Color(0.642,0.224,0.224,0.224)
		logColor= Color(0.642,0.224,0.224)
		logMessage="Numbers only!"
		$inputLineEdit.text=old_text
		$inputLineEdit.caret_column=old_text.length()

	$logMessage.add_theme_color_override("font_outline_color", logOutlineColor)
	$logMessage.add_theme_color_override("font_color", logColor)
	$logMessage.text=logMessage

func check(num):
	if num>100 or num<1:
		logOutlineColor = Color(0.642,0.224,0.224,0.224)
		logColor = Color(0.642,0.224,0.224)
		logMessage = "Out of bounds!"
	else:
		if num<ans:
			logOutlineColor = Color(0.705,0.705,0.705,0.224)
			logColor= Color(0.705,0.705,0.705)
			logMessage="The number is greater"
			append(str(num)+ " is less than the number\n")
		elif num>ans:
			logOutlineColor = Color(0.705,0.705,0.705,0.224)
			logColor= Color(0.705,0.705,0.705)
			logMessage="The number is lesser"
			append(str(num) + " is more than the number\n")
		elif num==ans:
			logOutlineColor = Color(0.224,0.705,0.224,0.224)
			logColor= Color(0.224,0.705,0.224)
			logMessage="Correct!"
			updateGameState(gameState)
			append(str(num) + " is correct!\n")

func updateGameState(game_state):
	if game_state:
		$inputLineEdit.editable=false
		$subButton.text="Restart"
		gameState=false
	else:
		$inputLineEdit.editable=true
		$subButton.text="Submit"
		$logTextEdit.text=""
		$inputLineEdit.text=""
		gameState=true
		$logMessage.text=""
		ans = random.randi_range(1,100)
		print("New ans is " +str(ans))

func buttonPressed():
	if gameState:
		submit($inputLineEdit.text)
	else:
		updateGameState(gameState)

func inputSubmit(input):
	if gameState:
		submit(input)
	else:
		pass

func append(string):
	$logTextEdit.text += string


func back_pressed():
	get_tree().change_scene_to_file("res://scenes/mainScene.tscn")
	pass # Replace with function body.

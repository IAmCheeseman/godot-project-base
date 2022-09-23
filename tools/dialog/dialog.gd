extends CanvasLayer

@onready var text: RichTextLabel = %DialogText
@onready var timer := $Timer

var target_text := "[shake rate=30 level=4]Freedom is a choice. Choose for them.[/shake]"
var speed := 0.1
var punctuation_wait := 4.0

func _ready() -> void:
	text.text = "[center]%s[/center]" % target_text
	timer.wait_time = speed


func advance_text() -> void:
	text.visible_characters += 1
	var parsed_text := text.get_parsed_text()
	text.visible_characters = clamp(text.visible_characters, 0, parsed_text.length())
	
	var punctuation = ".!?"
	if parsed_text[text.visible_characters-1] in punctuation:
		timer.start(speed * punctuation_wait)
		return
	timer.start(speed)

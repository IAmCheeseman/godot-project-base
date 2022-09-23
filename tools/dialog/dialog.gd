extends CanvasLayer

@onready var text: RichTextLabel = %DialogText
@onready var timer := $Timer

var target_text := "These devs is terrible. [img]ui/assets/skull.png[/img]"
var speed := 0.1
var read_time := 2.0
var punctuation_wait := 4.0


func _ready() -> void:
	if target_text.length() % 2 == 0: target_text = " " + target_text
	text.text = "[center]%s[/center]" % target_text
	timer.wait_time = speed
	text.visible_characters = 1


func advance_text() -> void:
	text.visible_characters += 1
	var parsed_text := text.get_parsed_text()
	text.visible_characters = clamp(text.visible_characters, 0, parsed_text.length())
	
	var punctuation = ".!?"
	if parsed_text[text.visible_characters-1] in punctuation:
		timer.start(speed * punctuation_wait)
		return
	
	if parsed_text.length() in [text.visible_characters, text.visible_characters+1]:
		text.visible_characters += 1;
		if !timer.is_connected("timeout", Callable(self, "queue_free")):
			timer.connect("timeout", Callable(self, "queue_free"))
		timer.start(read_time)
		return
	timer.start(speed)

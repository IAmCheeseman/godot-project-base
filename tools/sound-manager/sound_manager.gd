extends Node2D
class_name SoundManager
## A class that creates a new AudioStreamPlayer or AudioStreamPlayer2D
## when you want to play a sound, so the previous sound doesn't get
## cut out.

@export var audio : AudioStream
@export var directional := false
@export_range(80, 24) var volume_mod := 0.0
@export_range(1, 100) var pitch_shift_range := 1
@export var autoplay := false
@export var loop := false
@export var attenuation := 5.0
@export var max_dist := 2000.0
@export var free_on_finish := false
@export_enum("Master", "Ambient", "Music", "SFX", "Reverb", "ReverbLow") var bus: int

signal finished


func _ready() -> void:
	if autoplay: play()


## Plays the sound one time.
func play(vol_mod=volume_mod):
	# Creating the audio player
	if !audio: return

	var new_audio_player
	match directional:
		true:
			new_audio_player = AudioStreamPlayer2D.new()
			new_audio_player.attenuation = attenuation
			new_audio_player.max_distance = max_dist
		false:
			new_audio_player = AudioStreamPlayer.new()
		_:
			push_error("What.")

	# Setting parameters
	new_audio_player.stream = audio
	new_audio_player.bus = bus
	new_audio_player.autoplay = true
	new_audio_player.volume_db = vol_mod
	new_audio_player.pitch_scale = randf_range(1, pitch_shift_range)
	new_audio_player.connect("finished", self, "_on_audio_finished", [new_audio_player])

	add_child(new_audio_player)


## Stops all sounds.
func stop() -> void:
	Utils.free_children(self)


func _on_audio_finished(player):
	emit_signal("finished")
	if free_on_finish:
		queue_free()
		return
	if loop:
		player.play()
		return
	player.queue_free()


# Making sure sounds can't pile up and play all at once.
func _on_SoundManager_tree_exiting():
	for c in get_children():
		c.queue_free()

extends Control
@onready var chatbox: VBoxContainer = $ScrollContainer/chatbox
@onready var chatRoomTextLine = load('res://game/UI/chatRoomTextLine.tscn')
@onready var line_edit: LineEdit = $LineEdit
@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var chatboxheight:int = 233
@onready var color_rect: ColorRect = $ColorRect
@onready var timer: Timer = $Timer

func _ready() -> void:
	if scroll_container.size.y > 223:
		pass
	set_deferred("scroll_vertical", 600)
	
func sendmesseng():
	var cnb = chatbox.get_children()
	if len(cnb) >40:
		cnb[0].queue_free()
	var hh = chatbox.size.y
	var chattext:String=  Global.PlayerName + "：" + line_edit.text
	var chatline = chatRoomTextLine.instantiate()
	chatline.text = chattext
	chatbox.add_child(chatline)
	line_edit.text = ""
	timer.start()
	await get_tree().create_timer(0.01).timeout
	if hh > 180 :
		scroll_container.scroll_vertical = hh - 150
	line_edit.visible = false
	Global.Chatshow = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Enter"):
		if !Global.Chatshow:
			line_edit.grab_focus()
			line_edit.visible = true
			Global.Chatshow = true
			color_rect.color = "#00000047"
		elif Global.Chatshow:
			line_edit.visible = false
			Global.Chatshow = false
			if line_edit.text != "":
				sendmesseng()
			else:
				color_rect.color = "#00000020"
func _on_button_pressed() -> void:
	sendmesseng()


func _on_timer_timeout() -> void:
	color_rect.color = "#00000020"
	timer.stop()

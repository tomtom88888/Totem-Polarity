extends Node2D

const COURSE_1 = preload("res://levels/0/0_course_1.tscn")
const COURSE_2 = preload("res://levels/0/0_course_2.tscn")
const COURSE_3 = preload("res://levels/0/0_course_3.tscn")
var active_course
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active_course = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reload_current_course():
	print("sigma edgindssdg")
	print(active_course)
	match active_course:
		1:
			get_child(0).queue_free()
			var course_1 = COURSE_1.instantiate()
			active_course = 1
			course_1.connect("goIntoExit", _on_course_1_go_into_exit)
			add_child(course_1)
		2:
			get_child(0).queue_free()
			var course_2 = COURSE_2.instantiate()
			active_course = 2
			course_2.connect("goIntoExit", _on_course_2_go_into_exit)
			add_child(course_2)
		3:
			print("sigma edging")
			get_child(0).queue_free()
			var course_3 = COURSE_3.instantiate()
			active_course = 3
			course_3.connect("goIntoExit", finished_level)
			add_child(course_3)

func _on_course_1_go_into_exit() -> void:
	get_child(0).queue_free()
	var course_2 = COURSE_2.instantiate()
	active_course = 2
	course_2.connect("goIntoExit", _on_course_2_go_into_exit)
	add_child(course_2)

func _on_course_2_go_into_exit() -> void:
	get_child(0).queue_free()
	var course_3 = COURSE_3.instantiate()
	active_course = 3
	course_3.connect("goIntoExit", finished_level)
	add_child(course_3)

func finished_level():
	get_parent().switch_scene(preload("res://scenes/win.tscn"))

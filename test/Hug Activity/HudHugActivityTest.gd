# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name HudHugActivityTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://HugActivity/HUD_HugActivity.gd'

var spy_scene
var _runner: GdUnitSceneRunner

var _scene: Node
var _hud: HudHugActivityTest

func before_test() -> void:
	# we use before_test to have this code only once and reuse for each test
	_scene = spy("res://HugActivity/HUD_HugActivity.tscn")
	_runner = scene_runner(_scene)
	_hud = _scene.find_node("HUD_HugActivity")
	assert_bool(_scene.isTimerActive).is_equal(false)

func test__on_ChangeInstructionsTimer_timeout() -> void:
	#assert_bool(_scene.isTimerActive).is_equal(true)
	_runner.set_time_factor(10)
	yield(_runner.simulate_frames(20, 1000), "completed")
	assert_bool(_scene.isTimerActive).is_equal(true)
	
	

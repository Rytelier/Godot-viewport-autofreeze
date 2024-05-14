@tool
extends EditorPlugin

var viewport : SubViewport
var buttonPressed : bool

func _enter_tree():
	viewport = get_editor_interface().get_editor_viewport_3d()
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	pass

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		if event.is_pressed():
			viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
			buttonPressed = true
		else:
			viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
			buttonPressed = false

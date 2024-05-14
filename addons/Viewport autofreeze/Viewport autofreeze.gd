@tool
extends EditorPlugin

var viewport : SubViewport
var buttonPressed : bool
var autoFreezeToggle : CheckBox
var autoFreeze : bool

func _enter_tree():
	viewport = get_editor_interface().get_editor_viewport_3d()
	autoFreezeToggle = CheckBox.new()
	autoFreezeToggle.text = "Viewport auto freeze"
	add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, autoFreezeToggle)
	autoFreezeToggle.reparent(autoFreezeToggle.get_node("../../..").get_child(0))
	autoFreezeToggle.toggled.connect(SetAutoFreeze.bind())


func _exit_tree():
	autoFreezeToggle.queue_free()
	pass

func  SetAutoFreeze(b):
	autoFreeze = b
	if not b: viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS

func _input(event):
	if not autoFreeze: return
	
	if event is InputEventMouseButton or event is InputEventKey:
		if event.is_pressed():
			viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
			buttonPressed = true
		else:
			viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
			buttonPressed = false

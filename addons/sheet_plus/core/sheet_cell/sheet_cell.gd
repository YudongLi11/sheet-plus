@abstract
class_name SheetCell
extends PanelContainer


signal clicked()


## 内容
var content: Variant: set = set_content
## 水平对齐方式
var horizontal_alignment: HorizontalAlignment = HORIZONTAL_ALIGNMENT_LEFT: set = set_horizontal_alignment
## 垂直对齐方式
var vertical_alignment: VerticalAlignment = VERTICAL_ALIGNMENT_CENTER: set = set_vertical_alignment
## 宽度比
var width_ratio: float = 1.0: set = set_width_ratio
## 溢出模式
var overflow_mode: SheetGlobals.OverflowMode = SheetGlobals.OverflowMode.CLIP: set = set_overflow_mode


var _root: SheetRoot = null
var _current_theme: SheetPlusTheme = null


func _ready() -> void:
	self.mouse_entered.connect(self._on_mouse_entered)
	self.mouse_exited.connect(self._on_mouse_exited)
	self.gui_input.connect(self._on_gui_input)
	self.resized.connect(self._on_resized)


@abstract
func get_content_control() -> Control


@abstract
func set_content(new_content: Variant) -> void


@abstract
func set_horizontal_alignment(alignment: HorizontalAlignment) -> void


@abstract
func set_vertical_alignment(alignment: VerticalAlignment) -> void


func set_width_ratio(ratio: float) -> void:
	width_ratio = ratio
	self.size_flags_stretch_ratio = ratio


func set_overflow_mode(mode: SheetGlobals.OverflowMode) -> void:
	overflow_mode = mode
	self._handle_overflow.call_deferred()


func apply_other_config(root: SheetRoot) -> void:
	self._root = root
	match self._root.interaction_mode:
		SheetRoot.InteractionMode.Row:
			self.mouse_filter = Control.MOUSE_FILTER_IGNORE
		SheetRoot.InteractionMode.Cell:
			self.mouse_filter = Control.MOUSE_FILTER_STOP


func update_theme(theme: SheetPlusTheme) -> void:
	self._current_theme = theme


@abstract
func compare_values(value_a: Variant, value_b: Variant, sort_state: SheetGlobals.SortState) -> bool


@abstract
func _handle_overflow() -> void


func _on_mouse_entered() -> void:
	if self._root == null:
		return
	if self._root.interaction_mode == SheetRoot.InteractionMode.Row:
		return


func _on_mouse_exited() -> void:
	if self._root == null:
		return
	if self._root.interaction_mode == SheetRoot.InteractionMode.Row:
		return


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			self.clicked.emit()


func _on_resized() -> void:
	self._handle_overflow.call_deferred()


class CellConfig:
	var type: SheetGlobals.CellType = SheetGlobals.CellType.TEXT
	var content: Variant = null
	var horizontal_alignment: HorizontalAlignment = HORIZONTAL_ALIGNMENT_LEFT
	var vertical_alignment: VerticalAlignment = VERTICAL_ALIGNMENT_CENTER
	var width_ratio: float = 1.0
	var overflow_mode: SheetGlobals.OverflowMode = SheetGlobals.OverflowMode.CLIP

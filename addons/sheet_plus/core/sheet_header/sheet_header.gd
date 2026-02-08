@tool
class_name SheetHeader
extends PanelContainer


signal header_cell_sorted(cell_id: String, sort_state: SheetGlobals.SortState)


const SHEET_HEADER_CELL = preload("uid://stchjotskrjc")


var _current_theme: SheetPlusTheme = null
var _separators_visible: bool = true: set = set_separators_visible


func _ready() -> void:
	self.resized.connect(self._on_resized)


## 添加表头单元格
func add_cell(cell_resource: SheetHeaderCellResource) -> void:
	if cell_resource == null:
		return
	var cell: SheetHeaderCell = SHEET_HEADER_CELL.instantiate()
	cell.initialize(cell_resource, %CellsHBoxContainer)
	cell.update_theme(self._current_theme)
	cell.clicked.connect(self._on_cell_clicked)
	self.update_separators.call_deferred()


## 删除表头单元格
func remove_cell(cell: SheetHeaderCell) -> void:
	if cell == null:
		return
	%CellsHBoxContainer.remove_child(cell)
	if cell.clicked.is_connected(self._on_cell_clicked):
		cell.clicked.disconnect(self._on_cell_clicked)
	cell.queue_free()
	await get_tree().process_frame
	await get_tree().process_frame
	self.update_separators.call_deferred()


## 清空表头单元格
func clear_cells() -> void:
	for cell: SheetHeaderCell in %CellsHBoxContainer.get_children():
		%CellsHBoxContainer.remove_child(cell)
		if cell.clicked.is_connected(self._on_cell_clicked):
			cell.clicked.disconnect(self._on_cell_clicked)
		cell.queue_free()
	self.update_separators.call_deferred()


## 获取表头单元格
func get_cells() -> Array[SheetHeaderCell]:
	var return_array: Array[SheetHeaderCell] = []
	for cell in %CellsHBoxContainer.get_children():
		if cell is SheetHeaderCell:
			return_array.append(cell)
	return return_array


## 获取分割线（副本）
func get_separators() -> Array[Control]:
	var separators: Array[Control] = []
	var cells: Array = %CellsHBoxContainer.get_children()
	for i in range(cells.size()):
		var cell: SheetHeaderCell = cells[i]
		if i == 0:
			continue
		var separator: Control = cell.get_separator().duplicate()
		separator.position = cell.position
		separators.append(separator)
	return separators


func update_theme(theme: SheetPlusTheme) -> void:
	self._current_theme = theme
	self.add_theme_stylebox_override("panel", theme.header_background_stylebox)
	for separator: Control in %SeparatorContainer.get_children():
		separator.add_theme_stylebox_override("panel", theme.header_vertical_separator_stylebox)


func set_separators_visible(visible: bool) -> void:
	_separators_visible = visible
	for separator: Control in %SeparatorContainer.get_children():
		separator.visible = _separators_visible
	self.update_separators()


## 更新分割线
func update_separators() -> void:
	var cells: Array = %CellsHBoxContainer.get_children()
	for i in range(cells.size()):
		var cell: SheetHeaderCell = cells[i]
		var separator_visible: bool = self._separators_visible
		if i == 0:
			separator_visible = false
		cell.update_separator(separator_visible)


func _on_cell_clicked(cell_id: String) -> void:
	var index: int = %CellsHBoxContainer.get_children().find_custom(func(cell: SheetHeaderCell) -> bool:
		return cell.id == cell_id)
	var cur_cell: SheetHeaderCell = %CellsHBoxContainer.get_child(index)
	if cur_cell == null or not cur_cell.sortable:
		return
	# 确保只有一个单元格处于排序状态
	for cell: SheetHeaderCell in %CellsHBoxContainer.get_children():
		if cell.id != cell_id and cell.sort_state != SheetGlobals.SortState.NONE:
			cell.set_sort_state(SheetGlobals.SortState.NONE)
	self.header_cell_sorted.emit(cell_id, cur_cell.sort_state)


func _on_resized() -> void:
	self.update_separators()

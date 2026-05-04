# Table Plus Godot 4.5+ 版

**语言：** [English](README.md) | 简体中文

Table Plus 是一个可扩展的表格与数据展示 UI 插件，适用于 Godot。它面向只读表格展示，支持编辑器预览、运行时数据绑定、可配置表头、排序、主题和交互事件。

本仓库包含一个自定义的 `TablePlus` 控件、可复用的主题资源，以及一个可以直接打开的示例场景。

## 特性

- 只读表格渲染。
- 通过 `preview_data` 提供编辑器预览，运行时使用 `set_data()` 绑定数据。
- 内置单元格类型：文本、数字、货币、百分比、日期、布尔值、进度条。
- 使用 `TableHeaderCellResource` 配置表头。
- 支持列排序：无、升序、降序。
- 支持行级或单元格级交互模式。
- `TablePlusTheme` 可统一控制标题、表头、行、单元格、进度条和滚动条样式。
- 支持滚动条显示方式和自定义滚动步长。

## 安装

1. 将 `addons/table_plus/` 复制到你的项目 `addons/` 目录中。
2. 在 Godot 编辑器里通过 **Project Settings → Plugins** 启用插件。
3. 在场景中添加 `TablePlus` 节点，或者直接打开 `addons/table_plus/examples/` 下的示例场景。

## 快速开始

1. 在场景中添加一个 `TablePlus` 控件。
2. 创建表头资源并赋值给 `headers`。
3. 设置 `preview_data`，即可在编辑器中预览。
4. 在运行时调用 `set_data()` 填充真实数据。

```gdscript
extends Control

func _ready() -> void:
	$TablePlus.headers = [
		TableHeaderCellResource.new(),
		TableHeaderCellResource.new(),
		TableHeaderCellResource.new(),
	]

	$TablePlus.headers[0].id = "id"
	$TablePlus.headers[0].title = "ID"
	$TablePlus.headers[0].type = TableGlobals.CellType.TEXT

	$TablePlus.headers[1].id = "name"
	$TablePlus.headers[1].title = "姓名"
	$TablePlus.headers[1].type = TableGlobals.CellType.TEXT
	$TablePlus.headers[1].width_ratio = 2.0

	$TablePlus.headers[2].id = "score"
	$TablePlus.headers[2].title = "分数"
	$TablePlus.headers[2].type = TableGlobals.CellType.NUMBER

	$TablePlus.preview_data = [
		["001", "Alex", 42],
		["002", "Sam", 87],
	]

	$TablePlus.set_data([
		["001", "Alex", 42],
		["002", "Sam", 87],
	])
```

## 数据模型

Table Plus 接受二维数组：每个内层数组表示一行，每个值对应一个列。

- 每行的列数应与表头数量一致。
- 表头的 `type` 决定该列创建哪种单元格。
- `width_ratio` 控制列的相对宽度。
- `overflow_mode` 可选择裁剪或省略号显示。

### 表头资源字段

`TableHeaderCellResource` 支持：

- `id`：排序时使用的唯一标识。
- `title`：表头显示文本。
- `type`：该列对应的单元格类型。
- `width_ratio`：列宽权重。
- `sortable`：是否允许排序。
- `sort_state`：初始排序状态。
- `overflow_mode`：裁剪或省略号。
- `title_alignment`、`content_horizontal_alignment`、`content_vertical_alignment`。

## 支持的单元格类型

- `TableGlobals.CellType.TEXT`
- `TableGlobals.CellType.NUMBER`
- `TableGlobals.CellType.CURRENCY`
- `TableGlobals.CellType.PERCENTAGE`
- `TableGlobals.CellType.DATE`
- `TableGlobals.CellType.BOOLEAN`
- `TableGlobals.CellType.PROGRESS`

## 格式化选项

`TablePlus` 提供以下可配置项：

- 数字小数位、分隔符类型、舍入模式
- 货币小数位、舍入模式、货币符号
- 百分比小数位和舍入模式
- 日期显示格式
- 进度条填充方向，以及是否显示百分比文本

## 交互

`TablePlus` 会发出以下信号：

- `row_clicked(row_index, row)`
- `row_mouse_entered(row_index, row)`
- `row_mouse_exited(row_index, row)`
- `cell_clicked(row_index, column_index, cell)`

交互模式：

- `TableRoot.InteractionMode.Row`：行级交互
- `TableRoot.InteractionMode.Cell`：单元格级交互

排序行为：

- 点击可排序表头时，会在 `NONE → ASC → DESC` 之间切换。
- 排序会基于该列的单元格类型对当前数据进行处理。
- 表头 `id` 必须唯一。

## 主题

使用 `TablePlusTheme` 可以统一定制：

- 标题字体、字号、颜色
- 表头背景和分割线
- 行背景和悬停样式，包括斑马纹
- 各类单元格背景样式
- 布尔值图标
- 进度条外观
- 滚动条图标、样式和内边距

你可以通过 `custom_theme` 属性指定自定义主题资源。

## 使用注意

- `preview_data` 主要用于编辑器预览。
- 运行时数据请使用 `set_data()` 设置。
- 该控件更适合展示，不适合原地编辑数据。
- 如果数据列数和表头数量不一致，表格可能无法正确显示。
- `addons/table_plus/examples/` 下的示例场景展示了完整用法。

## 示例场景

打开 `addons/table_plus/examples/table_plus_example.tscn` 可以看到：

- 场景内表头资源配置
- 自定义主题的使用方式
- 编辑器预览数据
- 点击信号连接示例

## 许可证

MIT License。详情请查看 `LICENSE` 文件。



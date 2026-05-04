# Table Plus for Godot 4.5+

**Languages:** English | [简体中文](README.zh-CN.md)

Table Plus is an extensible table and data-display UI plugin for Godot. It is designed for read-only tables with editor preview support, runtime data binding, configurable headers, sorting, theming, and interaction events.

This repository includes a custom `TablePlus` control, a reusable theme resource, and an example scene you can open immediately after enabling the plugin.

## Features

- Read-only table rendering for structured data.
- Editor preview via `preview_data`, while runtime data is set with `set_data()`.
- Built-in cell types: text, number, currency, percentage, date, boolean, and progress.
- Configurable headers via `TableHeaderCellResource`.
- Column sorting with ascending / descending / none states.
- Row-level or cell-level interaction modes.
- Theme resource for title, header, row, cell, progress bar, and scrollbar styling.
- Scrollbar visibility options and custom scroll step support.

## Installation

1. Copy `addons/table_plus/` into your project’s `addons/` folder.
2. In the Godot editor, enable the plugin from **Project Settings → Plugins**.
3. Add a `TablePlus` node to your scene, or open the example scene in `addons/table_plus/examples/`.

## Quick Start

1. Add a `TablePlus` control to your scene.
2. Create header resources and assign them to `headers`.
3. Set `preview_data` to see content in the editor.
4. Call `set_data()` at runtime to populate the table with real data.

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
	$TablePlus.headers[1].title = "Name"
	$TablePlus.headers[1].type = TableGlobals.CellType.TEXT
	$TablePlus.headers[1].width_ratio = 2.0

	$TablePlus.headers[2].id = "score"
	$TablePlus.headers[2].title = "Score"
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

## Data model

Table Plus expects a 2D array: each inner array is one row, and each value maps to one column.

- The number of columns in each row should match the number of headers.
- Header `type` controls which cell scene is created for that column.
- `width_ratio` controls how much horizontal space a column receives relative to the others.
- `overflow_mode` can clip text or show an ellipsis.

### Header resource fields

`TableHeaderCellResource` supports:

- `id`: unique identifier used for sorting.
- `title`: visible header text.
- `type`: cell type for that column.
- `width_ratio`: column width weight.
- `sortable`: enables or disables sorting for the header.
- `sort_state`: initial sort state.
- `overflow_mode`: clip or ellipsis.
- `title_alignment`, `content_horizontal_alignment`, `content_vertical_alignment`.

## Supported cell types

- `TableGlobals.CellType.TEXT`
- `TableGlobals.CellType.NUMBER`
- `TableGlobals.CellType.CURRENCY`
- `TableGlobals.CellType.PERCENTAGE`
- `TableGlobals.CellType.DATE`
- `TableGlobals.CellType.BOOLEAN`
- `TableGlobals.CellType.PROGRESS`

## Formatting options

The `TablePlus` control exposes editor properties for:

- number decimal places, delimiter type, and rounding mode
- currency decimal places, rounding mode, and currency symbol
- percentage decimal places and rounding mode
- date display format
- progress bar fill direction and optional percentage text

## Interaction

`TablePlus` emits these signals:

- `row_clicked(row_index, row)`
- `row_mouse_entered(row_index, row)`
- `row_mouse_exited(row_index, row)`
- `cell_clicked(row_index, column_index, cell)`

Interaction modes:

- `TableRoot.InteractionMode.Row` for row-level interaction
- `TableRoot.InteractionMode.Cell` for cell-level interaction

Sorting behavior:

- Clicking a sortable header cycles through `NONE → ASC → DESC`.
- Sorting is applied to the current data using the header’s cell type.
- Header IDs must be unique.

## Theming

Use `TablePlusTheme` to customize:

- title font, size, and color
- header background and separators
- row backgrounds and hover states, including zebra striping
- per-cell-type backgrounds
- boolean icons
- progress bar appearance
- scrollbar icons, styles, and padding

You can assign a custom theme resource through the `custom_theme` property.

## Practical notes

- `preview_data` is intended for editor preview only.
- Runtime data should be assigned with `set_data()`.
- The table is optimized for display, not in-place editing.
- If the data row length does not match the header count, the table may not render correctly.
- The example scene under `addons/table_plus/examples/` shows a full working setup.

## Example scene

Open `addons/table_plus/examples/table_plus_example.tscn` to see:

- header resources configured in the scene
- custom theme usage
- editor preview data
- click signal connections

## License

MIT License. See `LICENSE` for details.


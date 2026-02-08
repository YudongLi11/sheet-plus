# Sheet Plus for Godot Engine 4.5+

Sheet Plus is an extensible table and data-display UI plugin for Godot 4.5 and later. It is designed for previewing structured table data inside the editor and displaying it at runtime. The plugin is optimized for read-only display rather than in-place data editing, and it supports multiple cell types, theme customization, and interaction events.

## Highlights

- Multiple cell types: text, number, currency, percentage, date, boolean, and progress — easy to extend with new cell types.
- Live editor preview: configure preview data in the editor to see the table immediately; update runtime data via the plugin's data API.
- Powerful theming: a configurable theme resource lets you customize and centrally manage table appearance (title, header, row backgrounds, separators, scroll bars, cell styles, etc.).
- Configurable headers and sorting: each column uses a header configuration resource to specify cell type, alignment, width weighting, and overflow behavior; column sorting is supported.
- Interaction modes: supports either row-level or cell-level interaction and emits events for clicks and mouse enter/exit so your game or tool can respond.
- Extensible architecture: clear structure and a factory-based approach make it easy to add new cell types and theme attributes.

## Main features

- Add a visual table control to your scene for editor preview and runtime display.
- Formatting options for numeric and monetary cells (decimal places, grouping separators, rounding), percentage display, and multiple date formats.
- Boolean values shown as icons; progress values shown with a progress bar and optional percentage text.
- Column width controlled by weight; overflow can be clipped or shown with an ellipsis when needed.
- Configurable scroll bar visibility and step size; supports zebra striping and hover styles for rows.

## Quick Start

1. Copy the `addons/sheet_plus/` folder into your Godot project's `addons/` directory (or clone the repository into the project).
2. Enable the plugin in the Godot editor: Project → Project Settings → Plugins → enable Sheet Plus.
3. Open the example scenes under `addons/sheet_plus/examples/` to see usage and configuration samples.

## Examples

See the example scenes included in `addons/sheet_plus/examples/` for how to configure headers, provide preview data, and connect interaction events.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

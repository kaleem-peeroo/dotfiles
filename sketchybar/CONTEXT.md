# SketchyBar

The macOS menu-bar widget that renders the top bar. A single `sketchybarrc` dispatches to a per-machine snippet based on the machine's ComputerName.

## Language

**Workspace**:
A named desktop space managed by AeroSpace (e.g. "1", "obsidian"). The bar shows only the focused workspace.
_Avoid_: Space (accepted slang, not canonical)

**Item**:
A single widget in the bar (e.g. `front_app`, `workspace`, `clock`), added at a position — `left`/`right`, or `e`/`q` to hug the notch.

**Machine**:
One of the two hosts the config runs on: `macbook` (MacBook Air, notch bar) or `macmini` (Mac mini, plain bar). Detected from ComputerName via `machines/detect.sh`.

**front_app**:
The leftmost item showing the currently focused application, icon-mapped via `icon_map_fn.sh`.

**aerospace_workspace_change**:
The event AeroSpace triggers via `sketchybar --trigger` when the focused workspace changes; carries `FOCUSED_WORKSPACE`.

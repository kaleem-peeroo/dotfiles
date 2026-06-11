# SketchyBar Config

Two config files for different machines:

| File | Machine | Notch handling |
|---|---|---|
| `sketchybarrc.notch` | MacBook (has notch) | `notch_width=180`, items use `q`/`e` positions to wrap around notch |
| `sketchybarrc` (default) | Mac Mini (no notch) | All items at `right` position, includes CPU, CPU temp |

## Switching configs

```bash
# For MacBook — notch-aware
cp ~/.config/sketchybar/sketchybarrc.notch ~/.config/sketchybar/sketchybarrc && sketchybar --reload

# For Mac Mini — no notch
# Current sketchybarrc is already the non-notch config, just reload
sketchybar --reload
```

Or symlink:
```bash
# Notch
ln -sf ~/.config/sketchybar/sketchybarrc.notch ~/.config/sketchybar/sketchybarrc && sketchybar --reload

# No notch (already active)
cp ~/.config/sketchybar/sketchybarrc ~/.config/sketchybar/sketchybarrc && sketchybar --reload
```

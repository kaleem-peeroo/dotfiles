# SketchyBar Config

Two config files for different machines:

| File | Machine | Notch handling |
|---|---|---|
| `sketchybarrc` | MacBook (has notch) | `notch_width=180`, items use `q`/`e` positions to wrap around notch |
| `sketchybarrc.nonotch` | Mac Mini (no notch) | All items at `right` position, includes CPU |

## Switching configs

```bash
# For MacBook — notch-aware
cp ~/.config/sketchybar/sketchybarrc ~/.config/sketchybar/sketchybarrc && sketchybar --reload

# For Mac Mini — no notch
cp ~/.config/sketchybar/sketchybarrc.nonotch ~/.config/sketchybar/sketchybarrc && sketchybar --reload
```

Or symlink:
```bash
ln -sf ~/.config/sketchybar/sketchybarrc.nonotch ~/.config/sketchybar/sketchybarrc && sketchybar --reload
```

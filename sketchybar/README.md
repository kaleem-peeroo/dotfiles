# SketchyBar Config

A single config for two machines, selected at runtime by machine name:

| Machine | ComputerName | Layout |
|---|---|---|
| MacBook Air | `MacBook Air` | Notch bar (`notch_width=180`, items at `e`/`q` positions), includes battery |
| Mac mini | `Kaleem's Mac mini` | Plain top bar, all items at `right`, includes CPU + CPU temp |

`sketchybarrc` detects the machine from `scutil --get ComputerName` and sources the matching snippet from `machines/`:

- `machines/macbook.sh` — MacBook Air right-side items
- `machines/macmini.sh` — Mac mini right-side items
- `machines/detect.sh` — the detection logic (tested in `tests/machine_detect_test.sh`)

Unknown machines default to the Mac mini layout. See `docs/adr/0001-single-config-machine-detection.md` for the reasoning.

## Reload

```bash
sketchybar --reload
```

No switching needed — the config picks the right layout automatically on each machine.

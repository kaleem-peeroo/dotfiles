# Single sketchybar config with hostname-based machine detection

The MacBook Air (notch) and Mac mini share dotfiles via git but need different sketchybar layouts (notch bar split vs. plain top bar, and differing right-side item sets). We consolidated the three configs (`sketchybarrc`, `sketchybarrc.notch`, `sketchybarrc.nonotch`) into one dispatcher that detects the machine from `scutil --get ComputerName` and sources a per-machine snippet, replacing the delete/copy/rename switching workflow.

## Considered Options

- **Symlink** (`ln -sf sketchybarrc.notch sketchybarrc`): minimal change, but variants still had to be mirrored by hand, and had already drifted (`nonotch` was missing cpu_temp, herdr, battery).
- **Single config + detection (chosen)**: one source of truth for everything shared; each machine's items live in exactly one snippet (`machines/macbook.sh` / `machines/macmini.sh`). No switching step. Per-machine items are still defined in both snippets, so a shared right-side item (e.g. discord) still needs editing in two places.

## Consequences

- Detection keys on the human-facing ComputerName ("MacBook Air", "Kaleem's Mac mini"), not `hostname -s` ("Mac-2"), which is DHCP-derived and can change.
- Unknown machines default to the Mac mini layout.

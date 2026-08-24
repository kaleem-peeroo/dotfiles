# Work MacBook Pro profile (macbook layout minus network + discord)

The Work MacBook Pro and the personal MacBook Air both match `*MacBook*` in detection, so they shared the `macbook` layout. The work machine should not show the `network` (wifi throughput) or `discord` widgets, so we added a third machine profile rather than editing the shared `macbook.sh`.

## Decision

- Detection in `machines/detect.sh` gains a `*Work*` clause before `*MacBook*`, so a ComputerName containing "Work" selects the work profile. This laptop was renamed from "Kaleem's MacBook Pro" to "Kaleem's Work MacBook Pro".
- `machines/work.sh` is the `macbook.sh` layout with the `network` and `discord` items removed; every other item (memory, cpu_temp, volume, battery, calendar, clock, outlook, teams, spotify, herdr) is unchanged.

## Considered Options

- **Edit `macbook.sh` in place**: would also strip network + discord from the personal MacBook Air, which still uses that layout.
- **Third snippet + detection clause (chosen)**: keeps `macbook.sh` intact, follows the existing per-machine snippet pattern, and keeps selection automatic via ComputerName.

## Consequences

- A shared item still has to be mirrored across all three snippets if it changes.
- Any other Mac whose ComputerName contains "Work" will get the work profile; the default for unknown machines remains the Mac mini layout.

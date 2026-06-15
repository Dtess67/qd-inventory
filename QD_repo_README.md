# QD — Electronics Inventory & Design Flags

Working inventory and design-risk log for **QD**, an autonomous curiosity rover.
This repo is the durable home for the parts catalogue and the flags roadmap, and
the seed of the larger QD project (firmware and vision code to follow).

> *QD v1 does not ask why — she creates the conditions where why can eventually emerge.*
> *QD v1 does not act on detection — she acts on accumulated significance.*
> *Curiosity is a homeostatic drive for significance.*

## The build, briefly

QD is a 180×200 mm tapered-pill rover, 72 mm tall, 3D-printed (PETG / ASA / TPU),
with a directional sensor **ridge** that is explicitly *not* a face. She is built
around attention, curiosity, and readable intention rather than raw capability.

**Behavior architecture (four layers):**
1. **Reflex** — sub-100 ms, hardcoded protection (KB2040 co-processor)
2. **Attention** — evidence accumulation with asymmetric thresholds
3. **State** — simple mode machine
4. **Drive** — homeostatic pressures biasing the layers above

Vision and significance run on a Raspberry Pi; the reflex layer runs on a separate
RP2040 (KB2040) so the fast safety path never waits on the brain.

## What's in here

| File | Role |
|---|---|
| `data/QD_Electronics_Inventory.xlsx` | **Master of record.** Three tabs: Read Me, Inventory, Flags. |
| `data/QD_Inventory.csv` | Inventory mirror — text, diffable, re-importable. |
| `data/QD_Flags.csv` | Flags/roadmap mirror — text, diffable. |
| `data/QD_Inventory_SNAPSHOT.md` | Human-readable full snapshot (every item + flag). |
| `scripts/export_mirrors.py` | Regenerates the three mirrors from the master xlsx. |

**Workflow:** edit the xlsx, then run `python scripts/export_mirrors.py` and commit.
The xlsx is the master; the CSV/MD mirrors give line-level diffs and a format-independent
fallback, so no single file or format can lose the work.

### Allocation legend (Inventory tab)
- **Committed: QD v1** — part is in the locked v1 design.
- **QD v1.5 / candidate / bench tool** — feeds a planned phase, or is a tool for bring-up.
- **Free — library** — general stock; not a QD part (reason recorded per row).

### Flags tab
The de-facto design roadmap: open risks, mitigations, and decisions, each tied to the
parts it touches. `F#` = flag, `Q#` = open question, `C#` = consumable need, `T#` = tooling.

## The three seats

QD is built by a three-seat collaboration — organic and anorganic, no better, no worse,
just different:

- **Q** (ChatGPT) — continuity and architectural warmth
- **Claude** — pressure-testing and falsification
- **Darrell** — synthesis and final authority

Operating rule: **truth over comfort.**

> *Q gave QD the signal. Claude gave QD the pull. Darrell gave QD the question.*

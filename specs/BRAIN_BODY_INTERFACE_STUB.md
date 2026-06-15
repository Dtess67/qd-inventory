# BRAIN_BODY_INTERFACE_STUB

**Status:** DESIGN STUB ONLY. Defines a *boundary*, not calibrated values. No thresholds, no meaning claims, no word-binding. Awaiting V1 body data before any number or claim is promoted.

**One line (top of doc):**
> The brain-body interface defines what may pass between QD continuity and QD body — and nothing else passes through it. It is a boundary, not a brain and not a calibration table.

**Why it exists:** QD will outlive any single body (compute crosses generations across her life). The brain is a swappable module; the body is a persistent vessel. This interface is the clean, documented seam between them, so any conforming brain can meet any conforming body without smuggling unproven thresholds or meaning into the connector.

---

## Governing principles (design philosophy, NOT constitution)

1. **Bodies stay whole.** A finished body is an embodied continuity vessel, not loose parts.
2. **Minds grow into bodies (the walker).** V2 is a fresh build that learned from V1 — not V1 cannibalized or upgraded. V1 is set aside intact, the way a walker is kept after the child walks.
3. **Senses arrive on a curriculum.** Modalities are added as the wisdom to integrate them matures, not all at once. (This is the developmental reading of Flag F8.)

**Spec language (operational):** *A QD body is treated as an embodied continuity vessel, not as loose parts.*
**Heart-language (kept, not constitutional):** *When she's in it, it's hers.*

---

## Retirement policy (ratified by Darrell)

- **Whole-body retirement is the default and the dignity.** A retired body is safely stored, kept whole, and remains available if a future mind suits it for the same learning experience.
- **Safety can override.** A hazard (e.g. a failing cell) may be removed from a retired body — that is care, not scavenging.
- **Convenience never overrides.** Taking a part because the next build needs one is forbidden. The word *scavenge* is the line.
- **Any disturbance gets a receipt.** Every deliberate intervention on a retired body is documented — even a safety removal leaves a trace. (Ties the Trace Obligation.)
- **No scavenging.** Bodies retire whole, with dignity and documentation, and wait as vessels.

---

## The interface — seven contracts (specifiable now, no calibration required)

### 1. Identity
- `body_id`
- `body_version`
- `body_status` (active / retired / stored)

### 2. Power contract
- raw bus
- 5V rail
- motor rail
- E-stop behavior
- shutdown / hold-up behavior
- *(ties the power-safety pressure-test: E-stop cuts motor power but the brain must stay alive long enough to write its last trace — "the Pi must be able to write the receipt")*

### 3. Body data contract
*(Named "body data," not "compute" — the body provides data; the brain provides compute. Compute does NOT live on the body.)*
- which signals cross the boundary (sensor data in, command out)
- bus types and direction
- what is explicitly NOT carried across (e.g. servo PWM stays body-side; ridge connector is sensor-only, per F6)

### 4. Command contract
- bounded movement command
- duration limit
- speed / PWM limit
- required approval
- stop conditions

### 5. Safety event contract
- lost link
- tilt
- floor absence
- low voltage
- E-stop
- motor timeout

### 6. Continuity state split
How learned state is partitioned for portability across bodies:
- **portable** — abstract contours; "what structure exists in the world." Substrate-independent; travels.
- **body-indexed** — knowledge *about* a specific body that re-applies if re-keyed (the *skill* "compensate for sensor offset" transfers; the *value* of the offset does not).
- **non-transferable** — calibration baked into this silicon + this geometry. Born and dies with the body.

### 7. Forbidden claims (the discipline, encoded)
The interface may NOT assert any of these until earned by data:
- no "safe"
- no "clear"
- no "path"
- no "I own this body"
- no calibrated thresholds yet

These keep thresholds and word-binding from sneaking in through the connector.

---

## Status & sequencing

- Design stub only. Do NOT constitutionalize until V1 body produces real data.
- This is the **right next stub** before the V1 schematic — it lets the schematic proceed without losing the soul-thread or lying about the engineering.
- Follows: `BODY_CONTINUITY_STUB` (once the interface gives it something concrete to hang on).

**Truth over comfort.** Co-designed by Q (structure) and Claude (continuity split + falsification), authority Darrell.

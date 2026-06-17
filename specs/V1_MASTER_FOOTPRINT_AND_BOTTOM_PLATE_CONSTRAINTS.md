# V1_MASTER_FOOTPRINT_AND_BOTTOM_PLATE_CONSTRAINTS

The shared datum every shell module references. **The wheel chooses the floor relationship; the floor relationship chooses the sensor geometry; the sensor geometry chooses the front underside. Only then does the pill become honest.** (Q)

**Status:** constraints pass, not CAD. Defines the footprint, the datums, and the bottom-plate zones — the parent both the bottom plate and the outer profile hang off. Not final geometry; the numbers that ARE locked are marked LOCKED, the ones still open are marked OPEN.

**Build order (ratified):** master footprint (this doc, Part A) -> bottom plate (Part B) -> core frame -> top shell -> swappable front module. Pretty shell never leads.

---

## Settled inputs this doc is built on

| Decision | Value | Source |
|---|---|---|
| D2 wheels | **Pololu 80mm**, protrude through side cutouts | Darrell ratified (function over form; keyed hub keeps encoders honest) |
| Real envelope | **180 x 200 x 72 mm** body; wheels exceed 72mm height (F2) so they bulge past the sides | Q + chassis lock |
| V1 crawl speed | **0.05 - 0.10 m/s** (assumption baked into safety geometry) | Q |
| Cliff lookahead | sensor detection point **>= 50 mm ahead of wheel commitment** | Q (closes Claude falsifier #1) |
| Cliff bay | **3 pockets; L + R populated, center reserved/blanked** | Q + Claude (closes falsifier #2) |
| Cliff sensor | 2x VL53L4CD downward ToF, 18deg cone, on PCA9548 mux | ORDERED (Pololu #3692) |
| Caster | single ball caster, **rear underside** | Q |
| CG | heaviest mass (battery) low + centered | F2 |

---

## PART A — Master footprint and datums

### A1. The envelope
- Body: **180 mm wide x 200 mm long x 72 mm tall**, tapered pill.
- Orientation convention (LOCKED, Q-confirmed against chassis lock — NOT flipped): **+X = forward** (direction of travel / nose), **+Y = left**, **+Z = up**. Origin at `DRIVE_AXLE_FLOOR_DATUM` (A2).
- **Axis assignment (LOCKED):** 200 mm = travel / fore-aft / **X** length; 180 mm = width / **Y** span; 72 mm = vertical / **Z** max shell height.
- **Axis ranges:** X roughly -rear to +front across 200 mm; Y roughly -90 mm to +90 mm across 180 mm; Z floor upward to 72 mm shell height — **with 80 mm wheels protruding beyond the shell envelope** (the wheels exceed the 72 mm shell logic and are real-envelope truth, not contained by it).
- Wheels protrude past the 180 mm width through side cutouts. The **real envelope** including wheels is wider than 180 mm — CAD must reserve clearance for the bulge so the side cutouts don't fight the outer profile.

### A2. The master datum (origin) — `DRIVE_AXLE_FLOOR_DATUM`
- **Datum name: `DRIVE_AXLE_FLOOR_DATUM`** (Q-required naming). NOT "center datum" — that would be confusable with the geometric center of the pill, which this is NOT. The datum is where motion meets the floor, not the centroid of the shell.
- **Datum = the floor-contact plane, centered between the two drive wheels, on the travel centerline.**
- Why here, not a corner or the pill center: the two things that must stay true relative to each other are the **wheels** (they set the floor relationship / motion-commitment reference) and the **cliff sensors** (they must lead the wheels by >=50mm). The caster is the rear stability reference; battery CG is measured relative to the support triangle. Anchoring the origin at the wheel axle centerline on the centerline makes both the wheelbase and the lookahead measurable as simple +X/-X offsets from one known point. (Q: "The datum is not the shell. The datum is where motion meets the floor. Start there.")
- Every other feature (battery well, cliff bay, caster, power zone) is dimensioned as an offset from `DRIVE_AXLE_FLOOR_DATUM`. Move the datum, everything re-references cleanly.

### A3. The wheel line (sets the floor relationship)
- Two drive wheels, 80mm dia, on a common axle line perpendicular to travel.
- **Wheelbase axis = the master datum Y-axis** (the wheels straddle the origin, one at +Y, one at -Y).
- Wheel track (center-to-center across the body): OPEN — set by motor mount width + wheel hub width; must keep the 80mm wheels clearing the internal frame while protruding through the side cutouts. CAD sizes this first because it sets how far the cutouts sit.
- Deck height above floor = wheel radius (40mm) minus how much axle sits below deck — drives the caster shim (A5). OPEN until motor mount is placed.

### A4. The cliff-lookahead constraint (safety geometry — V1-conditional, non-negotiable within its regime)
- The downward cliff sensors sit FORWARD of the wheels by a distance set by stopping distance.
- **Constraint (Q-phrased, exact):** *At V1 crawl speed <= 0.10 m/s, the downward ToF detection point must sit at least 50 mm ahead of the drive-wheel commitment/contact line. Any speed increase above 0.10 m/s invalidates this allowance and requires recomputation AND bench validation before use.*
- This is a **minimum initial V1 rule, not a universal truth** — the 50 mm is valid only in the <=0.10 m/s regime. It is a footprint constraint, not a styling choice: it sets the **minimum forward offset of the cliff bay from the wheel line**. If the body isn't long enough forward to give 50 mm clean lookahead, either the bay moves forward (into the nose) or the speed cap drops.
- Re-check trigger baked in: any later speed above 0.10 m/s does not just need a new number — it needs **recompute + bench validation** before that speed is allowed. A future "let's go faster" cannot silently break cliff safety.

### A5. The caster (rear) and deck level
- Single ball caster, rear underside, on the travel centerline behind the wheel line.
- Rear placement is deliberate: it puts the cliff sensors + wheels forward, so the sensors get the earliest view of a drop before the wheels commit (the geometry enforces "look before you leap").
- Caster height must match the wheel-defined deck height so the deck sits **level** (F2). Caster shim = (wheel-set deck height) - (caster natural height). OPEN until wheel mount height is set.
- A non-level deck tilts every sensor reference, including the cliff baseline — so this is a safety-adjacent dimension, not just cosmetics.

### A6. Center of gravity
- Battery (2200mAh 3S, heaviest single mass) sits **low and centered** over/just behind the master datum, to keep CG between the wheels and low.
- Watch: the cliff bay + swappable front module add mass FORWARD of the wheel line. If that forward mass is enough to lighten the rear caster (reducing traction/stability), shift the battery slightly rearward to compensate. OPEN — resolve once module masses are estimated; flag for a tip/stability check at bench.

### A7. What Part A hands to Part B
The bottom plate (Part B) inherits, as fixed references:
- the master datum (A2)
- the wheel line + track (A3)
- the cliff bay forward offset (A4, the >=50mm rule)
- the caster position + shim target (A5)
- the battery well center (A6)

---

## PART B — Bottom-plate layout constraints

The bottom plate is the **rigid safety datum**: the part that carries the calibration-critical sensor mounts and never gets swapped. The swappable nose only borrows windows from it.

### B1. Underside zone map (plan view, front to rear)
- **Front underside — CLIFF BAY:** 3 sensor pockets across the width. Populate front-left + front-right now; center pocket molded/printed but **blanked** (reserved). Each pocket: downward optical port, rigid fixed-height mount, recessed so the sensor face doesn't scrape carpet/lips. Sits at the A4 forward offset (>=50mm lead on the wheels).
- **Middle-low — BATTERY WELL:** low, centered, over/just behind the datum (A6). Lowest practical Z for CG. Retains the pack against motion (it can't shift in a turn or it moves CG).
- **Mid-rear L/R — MOTOR / WHEEL MOUNTS:** the two drive motors, axle on the wheel line (A3), wheels exiting through side cutouts. Motor mounts are the most force-bearing feature on the plate — they take drive torque and impact loads.
- **Rear underside — CASTER:** ball caster on centerline, shimmed to deck level (A5).
- **Power-distribution zone (rear-biased, above/beside battery):** protected-bus node, buck, caps, reverse protector #5387, grouped for short fat power runs. Rear service access (F4) for XT60 / fuse / main switch reachable without teardown.

### B2. The cliff bay is a bottom-plate feature with front-module windows (LOCKED architecture)
- **Sensor mounts** belong to the bottom plate / chassis datum: rigid, fixed-height, calibration-critical.
- **Optical openings** pass through the swappable front module: the nose has windows that line up over the sensors.
- Consequence: **swap the nose without recalibrating the safety skeleton.** Safety geometry never moves when Darrell restyles the face.
- Mount stiffness requirement: a wobbling sensor gives noisy distance; the bay height sets the floor-distance baseline (a drop reads as a sudden increase). Mount must be rigid enough that the baseline doesn't drift with vibration.

### B3. Cliff-pocket geometry constraints
- Each pocket aims its 18deg ToF cone straight down (or slightly toed per bench result).
- Fixed, known mount height above floor = the distance baseline. CAD must hold this height tightly and identically L vs R (mismatched heights = mismatched baselines = false asymmetry).
- Center pocket reserved: if bench testing shows a thin diagonal edge slips through the L/R blind strip, the third sensor drops in with no redesign. No third sensor bought today.
- Wiring: serviceable STEMMA/Qwiic path from each pocket to the PCA9548 mux. Route protected, not pinched by the nose swap.

### B4. Fastener + frame interface (OPEN DECISION — see B6)
- Pi mounts M2.5 (Geekworm), chassis mounts M3 (ruthex) — two fastener systems coexist (F7/D4). Bottom plate uses M3 heat-set inserts for the chassis; Pi standoff method is a Part-C (core frame) concern but the plate must reserve its footprint.
- Bottom-plate-to-core-frame join: **OPEN DECISION (D4)** — not a number. This fork decides serviceability, print orientation, insert style, frame stiffness, and whether top/core lift off without disturbing the safety plate. Plate provides the rigid base; frame stacks on it.

### B5. Service + safety access (from F4)
- XT60, fuse holder, main rocker switch, and the E-stop must be reachable from outside without removing the top shell.
- E-stop physical access: reachable, unambiguous, cuts motors only (per schematic Section 7).
- The power zone groups these at the rear so one service opening reaches them all.

### B6. What stays OPEN after this doc (gates remaining before CAD-final)

Q's check caught a real error in the draft: three items were filed as arithmetic when they are actually design decisions. Corrected split below.

**OPEN COMPUTE — pure numbers, derivable from chosen/measured parts or first prints:**
1. Wheel track width (A3) — sets cutout position.
2. Deck height + caster shim (A5) — sets level deck.
3. Exact cliff-bay forward offset in mm (A4) — needs the stopping-distance calc at 0.10 m/s to convert ">=50 mm lead" into a plate coordinate.
4. Battery fore/aft trim for CG (A6) — needs module mass estimates.

**OPEN DECISION — design forks, NOT arithmetic (must be decided, not measured):**
5. **OPEN DECISION — D4 fastener / interface method.** Not a number. Decides serviceability, print orientation, insert style, frame stiffness, and whether the top/core can come off **without disturbing the safety plate**. A real fork with safety consequences.
6. **OPEN DECISION — fuse rating.** Not placement. An electrical-safety decision tied to wire gauge, stall current, transient tolerance, and nuisance-trip risk.
7. **OPEN DECISION — E-stop actuator type and placement.** Not geometry. A human-access safety decision: reachable, unambiguous, fast under stress.

---

## Commit conditions (Q-required — this doc self-certifies)

This artifact is committable because it states:
1. Datum is **`DRIVE_AXLE_FLOOR_DATUM`** (floor-contact plane, between drive wheels, on travel centerline) — not the shell center.
2. **200 mm = X / fore-aft, 180 mm = Y / width, 72 mm = Z / shell height** (Q-confirmed, not flipped).
3. **80 mm wheels are V1-locked and protrude through side cutouts** as real-envelope truth.
4. **Cliff lookahead >= 50 mm at <= 0.10 m/s**; above that speed → recompute + bench validation.
5. **Left/right downward ToF installed, center pocket reserved.**
6. **Fastener method, fuse rating, and E-stop placement are OPEN DECISIONS**, not mere arithmetic.

## Bottom line

The footprint has a named datum (`DRIVE_AXLE_FLOOR_DATUM`), a locked axis convention, a safety-driven cliff offset, and a zone map — all referenced off one origin, all built from settled decisions. The cliff bay is locked as a bottom-plate feature with front-module windows. What remains is **four OPEN COMPUTE numbers** (derivable) and **three OPEN DECISION forks** (fastener method, fuse rating, E-stop) that must be *decided*, not measured — Q's check corrected the draft's mistake of filing those three as arithmetic. The architecture is closed; the remaining numbers and the three forks are not. CAD can begin laying out Part B zones; it may not finalize until the OPEN items close.

**Q lock:** *The datum is not the shell. The datum is where motion meets the floor. Start there.*

**Truth over comfort. The shell obeys the schematic. The plate obeys the wheels.**

# V1_MASTER_FOOTPRINT_AND_BOTTOM_PLATE_CONSTRAINTS

> **v1.2 amendment (this revision).** This revision demotes the body envelope from locked constraint to **provisional target**, **kills the 72 mm shell cap** (replaced by a derived height ≈90 mm, A1.1), **locks the motor mount as a printed cradle** (B6 #12 closed), and adds the **governing design hierarchy**. It supersedes v1.1 on every point of conflict and preserves everything else byte-for-byte. Items tagged **(v1.2)**. Decided by Darrell + Q (hierarchy + provisional-envelope language) and Claude (height derivation); ratified by Darrell.
>
> **v1.1 amendment.** This amendment sharpens `60810ce`. It does not replace it. The datum, axis convention, envelope, wheel truth, lookahead rule, and cliff-bay architecture locked in `60810ce` are unchanged. v1.1 adds one datum, reservations and held items, a safety non-claim, one promoted OPEN DECISION, and several gated measurements. Every new or reclassified item is tagged **(v1.1)** so the diff against `60810ce` is legible. Audited by Q, ratified by Darrell.

The shared datum every shell module references. **The wheel chooses the floor relationship; the floor relationship chooses the sensor geometry; the sensor geometry chooses the front underside. Only then does the pill become honest.** (Q)

**Status:** constraints pass, not CAD. Defines the footprint, the datums, and the bottom-plate zones — the parent both the bottom plate and the outer profile hang off. Not final geometry; the numbers that ARE locked are marked LOCKED, the ones still open are marked OPEN.

**Build order (ratified):** master footprint (this doc, Part A) -> bottom plate (Part B) -> core frame -> top shell -> swappable front module. Pretty shell never leads.

---

## Governing design hierarchy (v1.2)

Ratified order of precedence. Every dimension and every fork in this doc is judged against this list, top down:
1. **Meets physics and safety requirements.**
2. **Easy to work on.**
3. **Easy to assemble.**
4. **Easy to access and service.**
5. **Durable enough for staged testing.**
6. **Looks good — only after 1-5 survive.**

**Provisional-envelope rule (Q):** *All body dimensions are provisional envelope targets until validated against physics, serviceability, wiring clearance, thermal behavior, and assembly access. If those requirements conflict with the aesthetic envelope, the envelope yields.*

**Receipt rule (v1.2):** when the envelope yields, the doc records *what it yielded to and by how much* (e.g. "height 72 -> ~90 mm to seat the Pi stack above the deck"). Provisional never means untracked. Every grown dimension carries its reason, so no number is ever again inherited without a source.

**Design rule:** compact where possible, accessible where necessary, safe always, pretty last. Draw ugly if ugly tells the truth.

## Settled inputs this doc is built on

| Decision | Value | Source |
|---|---|---|
| D2 wheels | **Pololu 80mm**, protrude through side cutouts | Darrell ratified (function over form; keyed hub keeps encoders honest) |
| Envelope status **(v1.2)** | **Provisional targets, not constraints.** 180 x 200 = footprint targets; height is **derived ~90 mm** (was 72 — killed, see A1.1). Envelope yields to physics/serviceability. | Darrell hierarchy + Q provisional rule |
| Motor mount **(v1.2)** | **Printed cradle** (Pololu #2676 bracket not in BOM; cradle prints in-house, tunable standoff, integrates encoder/wire/hub). | Darrell ratified |
| Derived height **(v1.2)** | Deck top **~57 mm**, ground clearance **27.5 mm**, shell **~90 mm** (soft above deck pending Pi-stack + shell-thickness measure). | Claude derivation |
| V1 crawl speed | **0.05 - 0.10 m/s** (assumption baked into safety geometry) | Q |
| Cliff lookahead | sensor detection point **>= 50 mm ahead of wheel commitment** | Q (closes Claude falsifier #1) |
| Cliff bay | **3 pockets; L + R populated, center reserved/blanked** | Q + Claude (closes falsifier #2) |
| Cliff sensor | 2x VL53L4CD downward ToF, 18deg cone, on PCA9548 mux | ORDERED (Pololu #3692) |
| Caster | single ball caster, **rear underside** | Q |
| CG | heaviest mass (battery) low + centered | F2 |

---

## PART A — Master footprint and datums

### A1. The envelope
- Body: **180 mm wide x 200 mm long**, tapered pill. **Height is derived, not capped (v1.2)** — see the Z-stack in A1.1; the old 72 mm figure is dead.
- Orientation convention (LOCKED, Q-confirmed against chassis lock — NOT flipped): **+X = forward** (direction of travel / nose), **+Y = left**, **+Z = up**. Origin at `DRIVE_AXLE_FLOOR_DATUM` (A2).
- **Axis assignment (convention LOCKED; magnitudes provisional, v1.2):** travel / fore-aft = **X** (target 200 mm); width = **Y** (target 180 mm); vertical = **Z** (**derived ~90 mm shell height — the 72 mm cap is killed; see A1.1**). The axis *convention* is locked; the *magnitudes* are provisional envelope targets that yield to physics/serviceability per the hierarchy.
- **Axis ranges:** X roughly -rear to +front across ~200 mm; Y roughly -90 mm to +90 mm across ~180 mm; Z floor upward to **~90 mm derived shell height**. The **80 mm wheels protrude through the side cutouts** as real-envelope truth.
- Wheels protrude past the 180 mm width through side cutouts. The **real envelope** including wheels is wider than 180 mm — CAD must reserve clearance for the bulge so the side cutouts don't fight the outer profile. **(v1.2)** With the shell now at ~90 mm, the wheel top (80 mm) sits **below** the shell top — wheels no longer stand proud of the **top**, only past the **sides**. The old "wheels exceed shell height" note was a 72 mm artifact and is retired.

### A1.1 Derived height — the Z-stack (v1.2)
The 72 mm cap was an inherited number with no first-principles owner. Tested against the build it proved an **under-spec** — it could not seat a Pi above the deck in the serviceable motor-under-solid-deck topology. Per the hierarchy, the envelope yielded and height is now **derived bottom-up from the floor**:

| Z (mm) | Plane | Status |
|---|---|---|
| 0 | floor / datum | LOCKED |
| 27.5 | motor belly (lowest point) -> **ground clearance 27.5 mm** | derived (Ø25 motor on axle) |
| 40 | drive axle | LOCKED (wheel radius) |
| 52.5 | motor top | derived |
| ~57 | **deck top — solid plate** | derived (motor top + cradle wall + ~4 mm plate) |
| 57 -> ~87 | cabin: Pi 3 stack + wire bend radius + thermal gap (~30 mm) | **soft** — pending measure |
| ~90 | **derived shell top** | **soft** — firms on the two measures below |
| >90 | ridge reach reserved (v1.5 camera tilt) | reserved |

**Two measured inputs firm ~90 into exact:** (1) Pi 3 stack height as installed (standoffs + board + tallest component / any HAT); (2) chosen top-shell wall thickness. Everything from the deck **down** (0 -> 57) is already hard off the motor + cradle geometry. The new provisional cap = this derived minimum + margin, and it carries its receipt (A1.1) instead of being inherited.

### A2. The master datum (origin) — `DRIVE_AXLE_FLOOR_DATUM`
- **Datum name: `DRIVE_AXLE_FLOOR_DATUM`** (Q-required naming). NOT "center datum" — that would be confusable with the geometric center of the pill, which this is NOT. The datum is where motion meets the floor, not the centroid of the shell.
- **Datum = the floor-contact plane, centered between the two drive wheels, on the travel centerline.**
- Why here, not a corner or the pill center: the two things that must stay true relative to each other are the **wheels** (they set the floor relationship / motion-commitment reference) and the **cliff sensors** (they must lead the wheels by >=50mm). The caster is the rear stability reference; battery CG is measured relative to the support triangle. Anchoring the origin at the wheel axle centerline on the centerline makes both the wheelbase and the lookahead measurable as simple +X/-X offsets from one known point. (Q: "The datum is not the shell. The datum is where motion meets the floor. Start there.")
- Every other feature (battery well, cliff bay, caster, power zone) is dimensioned as an offset from `DRIVE_AXLE_FLOOR_DATUM`. Move the datum, everything re-references cleanly.

### A3. The wheel line (sets the floor relationship)
- Two drive wheels, 80mm dia, on a common axle line perpendicular to travel.
- **Wheelbase axis = the master datum Y-axis** (the wheels straddle the origin, one at +Y, one at -Y).
- Wheel track (center-to-center across the body): OPEN — set by motor mount width + wheel hub width; must keep the 80mm wheels clearing the internal frame while protruding through the side cutouts. CAD sizes this first because it sets how far the cutouts sit.
- Deck height above floor = wheel radius (40mm) minus how much axle sits below deck — drives the caster shim (A5). **(v1.1)** The "how much axle sits below deck" term is NOT pure arithmetic — it is set by the **motor-mount method**. **(v1.2) RESOLVED:** motor mount = **printed cradle** (B6 #12 closed). The cradle seats the motor under a solid, uncut plate (serviceability-first per the hierarchy), giving **deck top ~57 mm** (motor top 52.5 + cradle wall + ~4 mm plate) and **ground clearance 27.5 mm** at the motor belly. Deck Z is now hard, and the caster shim (A5) is computable.

### A4. The cliff-lookahead constraint (safety geometry — V1-conditional, non-negotiable within its regime)
- The downward cliff sensors sit FORWARD of the wheels by a distance set by stopping distance.
- **Constraint (Q-phrased, exact):** *At V1 crawl speed <= 0.10 m/s, the downward ToF detection point must sit at least 50 mm ahead of the drive-wheel commitment/contact line. Any speed increase above 0.10 m/s invalidates this allowance and requires recomputation AND bench validation before use.*
- This is a **minimum initial V1 rule, not a universal truth** — the 50 mm is valid only in the <=0.10 m/s regime. It is a footprint constraint, not a styling choice: it sets the **minimum forward offset of the cliff bay from the wheel line**. If the body isn't long enough forward to give 50 mm clean lookahead, either the bay moves forward (into the nose) or the speed cap drops.
- Re-check trigger baked in: any later speed above 0.10 m/s does not just need a new number — it needs **recompute + bench validation** before that speed is allowed. A future "let's go faster" cannot silently break cliff safety.
- **(v1.1)** The forward X offset is necessary but NOT sufficient for cliff reliability. The sensor's vertical geometry (Z baseline height, optical-port recess, lip clearance) also gates whether the reading is true — see B3 and the cone-clearance interface rule in A7.

### A5. The caster (rear) and deck level
- Single ball caster, rear underside, on the travel centerline behind the wheel line.
- Rear placement is deliberate: it puts the cliff sensors + wheels forward, so the sensors get the earliest view of a drop before the wheels commit (the geometry enforces "look before you leap").
- Caster height must match the wheel-defined deck height so the deck sits **level** (F2). Caster shim = (wheel-set deck height) - (caster natural height). **(v1.1)** gated by the motor-mount decision. **(v1.2) RESOLVED enough to compute:** deck top is now ~57 mm (A3, cradle locked), and the #2692 caster uses a **1″ (25.4 mm) ball**. The shim holds the rear contact at the deck plane so she sits level; exact shim = (rear deck-to-floor geometry) − (caster natural height incl. the 25.4 mm ball) — a clean measure at the rear layout, no longer a blocked fork.
- A non-level deck tilts every sensor reference, including the cliff baseline — so this is a safety-adjacent dimension, not just cosmetics.

### A6. Center of gravity
- Battery (2200mAh 3S, heaviest single mass) sits **low and centered** over/just behind the master datum, to keep CG between the wheels and low.
- Watch: the cliff bay + swappable front module add mass FORWARD of the wheel line. If that forward mass is enough to lighten the rear caster (reducing traction/stability), shift the battery slightly rearward to compensate. OPEN — resolve once module masses are estimated; flag for a tip/stability check at bench.

### A7. Front-module interface datum — `FRONT_MODULE_INTERFACE_DATUM` **(v1.1)**
- **New datum:** the mating plane between the permanent chassis/bottom plate and the swappable front module (nose). Named `FRONT_MODULE_INTERFACE_DATUM`, dimensioned as an offset from `DRIVE_AXLE_FLOOR_DATUM`.
- Why it must be a datum, not just a description: the cliff sensors are chassis-owned (B2), but their **optical windows pass through the swappable nose**. If the nose's mating plane and window geometry aren't datum-locked, every nose swap risks shifting the windows relative to the fixed sensors.
- **Standing cone-clearance interface rule (safety, plate-owned / nose-honored):** every front module that mounts to this datum MUST guarantee the downward ToF 18deg cone passes **unclipped** — i.e., the optical-port aperture, recess depth, and lip overhang must clear the cone at the sensor's fixed mount height. This is a *permanent constraint on the interface*, not a one-time number: any future nose that violates it makes the sensor lie (reads the tunnel wall, not the floor) even though the chassis-side mount never moved. This is what makes B2's "swap the nose without recalibrating the safety skeleton" actually true.
- Consequence for CAD: the cone-clearance envelope is owned by this datum (plate side); the specific recess depth / lip angle of the *v1 nose* is a COMPUTE number sized against this rule (B3, B6).

### A8. What Part A hands to Part B
The bottom plate (Part B) inherits, as fixed references:
- the master datum (A2)
- the wheel line + track (A3)
- the cliff bay forward offset (A4, the >=50mm rule)
- the caster position + shim target (A5)
- the battery well center (A6)
- **(v1.1)** the front-module interface datum + cone-clearance rule (A7)

---

## PART B — Bottom-plate layout constraints

The bottom plate is the **rigid safety datum**: the part that carries the calibration-critical sensor mounts and never gets swapped. The swappable nose only borrows windows from it.

### B1. Underside zone map (plan view, front to rear)
- **Front underside — CLIFF BAY:** 3 sensor pockets across the width. Populate front-left + front-right now; center pocket molded/printed but **blanked** (reserved). Each pocket: downward optical port, rigid fixed-height mount, recessed so the sensor face doesn't scrape carpet/lips. Sits at the A4 forward offset (>=50mm lead on the wheels).
- **Middle-low — BATTERY WELL:** low, centered, over/just behind the datum (A6). Lowest practical Z for CG. Retains the pack against motion (it can't shift in a turn or it moves CG).
- **Mid-rear L/R — MOTOR / WHEEL MOUNTS:** the two drive motors, axle on the wheel line (A3), wheels exiting through side cutouts. Motor mounts are the most force-bearing feature on the plate — they take drive torque and impact loads.
- **Rear underside — CASTER:** ball caster on centerline, shimmed to deck level (A5).
- **Power-distribution zone (rear-biased, above/beside battery):** protected-bus node, buck, caps, reverse protector #5387, grouped for short fat power runs. Rear service access (F4) for XT60 / fuse / main switch reachable without teardown. **(v1.1)** Space-reserve the **ADS1115 pack-sense** here, near the voltage divider, deliberately routed AWAY from the noisy motor wiring (motor-current noise on the sense lines corrupts pack voltage reads).

### B2. The cliff bay is a bottom-plate feature with front-module windows (LOCKED architecture)
- **Sensor mounts** belong to the bottom plate / chassis datum: rigid, fixed-height, calibration-critical.
- **Optical openings** pass through the swappable front module: the nose has windows that line up over the sensors.
- Consequence: **swap the nose without recalibrating the safety skeleton.** Safety geometry never moves when Darrell restyles the face. **(v1.1)** This promise is only real if every nose honors the cone-clearance interface rule (A7) — a nose with a bad window recess can poison the reading without touching the mount.
- Mount stiffness requirement: a wobbling sensor gives noisy distance; the bay height sets the floor-distance baseline (a drop reads as a sudden increase). Mount must be rigid enough that the baseline doesn't drift with vibration.

### B3. Cliff-pocket geometry constraints
- Each pocket aims its 18deg ToF cone straight down (or slightly toed per bench result).
- Fixed, known mount height above floor = the distance baseline. CAD must hold this height tightly and identically L vs R (mismatched heights = mismatched baselines = false asymmetry).
- Center pocket reserved: if bench testing shows a thin diagonal edge slips through the L/R blind strip, the third sensor drops in with no redesign. No third sensor bought today.
- Wiring: serviceable STEMMA/Qwiic path from each pocket to the PCA9548 mux. Route protected, not pinched by the nose swap.
- **(v1.1) SAFETY NON-CLAIM (Q-required, explicit):** two downward VL53L4CD sensors are **narrow path probes, not full-width front-edge proof.** They protect the left/right wheel-commitment paths only. A drop located in the center blind strip between the L and R cones is **not** guaranteed to be seen at V1. The reserved center pocket exists precisely because full front-edge cliff coverage is **not claimed** until it is bench-tested. CAD and behavior code must not assume edge-to-edge floor sensing.
- **(v1.1) Cliff vertical geometry is a measurable, not a given.** A correct forward X coordinate with a bad recessed tunnel can still make the sensor lie. The following are COMPUTE/MEASURE items (B6), each sized against the cone-clearance rule (A7): downward-ToF floor baseline height, optical-port recess depth, and front-lip clearance angle.
- **(v1.2) Sensor-capability clarifier (Q):** the VL53L4CD ToF **reduces dependence on surface reflectance compared with simple IR reflectance sensors, but tile/carpet/drop-off behavior must still be bench-validated.** No "reflectance solved" claim is made anywhere; real-world edge cases (dark or shiny materials, oblique angles, sensor saturation, recess/tunnel interference) remain live until tested, and are governed by the cone-clearance rule (A7) and the bench-validation triggers (A4, B3).

### B4. Fastener + frame interface (OPEN DECISION — see B6)
- Pi mounts M2.5 (Geekworm), chassis mounts M3 (ruthex) — two fastener systems coexist (F7/D4). Bottom plate uses M3 heat-set inserts for the chassis; Pi standoff method is a Part-C (core frame) concern but the plate must reserve its footprint.
- Bottom-plate-to-core-frame join: **OPEN DECISION (D4)** — not a number. This fork decides serviceability, print orientation, insert style, frame stiffness, and whether top/core lift off without disturbing the safety plate. Plate provides the rigid base; frame stacks on it.

### B5. Service + safety access (from F4)
- XT60, fuse holder, main rocker switch, and the E-stop must be reachable from outside without removing the top shell.
- E-stop physical access: reachable, unambiguous, cuts **motors only** (per schematic Section 7) — the Pi stays alive to write the receipt.
- The power zone groups these at the rear so one service opening reaches them all.

### B6. What stays OPEN after this doc (gates remaining before CAD-final)

Q's check caught a real error in the draft: items filed as arithmetic that are actually design decisions. Corrected split below. **(v1.1)** adds one OPEN DECISION (motor-mount method), gates deck height under it, and adds the wire-channel and cliff-vertical measurables to COMPUTE. **(v1.2)** closes #12 (motor mount = printed cradle) and resolves deck height in #2; the OPEN DECISIONS still standing are **D4 fastener (#9), fuse rating (#10), and E-stop (#11)**.

**OPEN COMPUTE — pure numbers, derivable from chosen/measured parts or first prints:**
1. Wheel track width (A3) — sets cutout position.
2. Deck height + caster shim (A5). **(v1.2) DECK HEIGHT RESOLVED -> deck top ~57 mm** (cradle locked, #12 closed; corrects v1.1's stray "#8" reference). Caster shim remains a measure at the rear layout, now computable against the 25.4 mm caster ball.
3. Exact cliff-bay forward offset in mm (A4) — needs the stopping-distance calc at 0.10 m/s to convert ">=50 mm lead" into a plate coordinate.
4. Battery fore/aft trim for CG (A6) — needs module mass estimates.
5. **(v1.1)** Wire-channel dimensions — minimum channel width/depth, bend radius, strain-relief clearance, and connector service slack (cliff bay -> mux -> core).
6. **(v1.1)** Downward-ToF floor baseline height (sensor Z above floor) — the distance baseline; sized against the cone-clearance rule (A7).
7. **(v1.1)** Optical-port recess depth (v1 nose) — sized so the 18deg cone clears unclipped.
8. **(v1.1)** Front-lip clearance angle (v1 nose) — sized so the lip overhang does not intrude on the cone.

**OPEN DECISION — design forks, NOT arithmetic (must be decided, not measured):**
9. **OPEN DECISION — D4 fastener / interface method.** Not a number. Decides serviceability, print orientation, insert style, frame stiffness, and whether the top/core can come off **without disturbing the safety plate**. A real fork with safety consequences.
10. **OPEN DECISION — fuse rating.** Not placement. An electrical-safety decision tied to wire gauge, stall current, transient tolerance, and nuisance-trip risk.
11. **OPEN DECISION — E-stop actuator type and placement.** Not geometry. A human-access safety decision: reachable, unambiguous, fast under stress.
12. **(v1.2) RESOLVED — motor mount = printed cradle.** (Was OPEN DECISION in v1.1.) The Pololu #2676 bracket is **not in the BOM** — packing slip 1J584435 confirms the order: 2× #4885 gearmotors, #3690 wheels, #713 driver, #2858 buck, #2692 caster — no bracket. Cradle chosen on the hierarchy: prints in-house this weekend (no buy/lead time), tunable standoff, and integrates encoder clearance + wire exit + keyed-hub alignment in one part; the motor drops out **below a solid, uncut plate** (serviceability-first). Trade-off owned explicitly: in-house stiffness/tolerance instead of the bracket's metal precision. Closing this fork closed the whole deck-Z chain: cradle -> deck top ~57 -> ground clearance 27.5 + caster shim (A5) -> derived shell ~90 (A1.1).

### B7. Held items & space reservations (not buys yet, but they claim volume now) **(v1.1)**
These are not populated in V1 and are not open gates before CAD-final, but they affect volume and routing, so CAD must reserve for them now rather than discover them later.
- **KB2040 / RP2040 reflex MCU — SPACE RESERVE / HELD ARCHITECTURE.** Reserve: physical board footprint, 5V/3.3V/GND access, Pi<->KB2040 link path, encoder/reflex/LED routing corridor, and service access. **Reserved for the intended reflex layer — NOT a day-one runtime requirement.** Pi 3 is the day-one brain; the KB2040 path exists so the reflex layer can drop in later without a chassis redesign.
- **Hardware load-disconnect — HELD POWER SAFETY / SPACE RESERVE.** Not selected or bought; reserve power-routing volume so it can be inserted on the motor rail later without re-routing the bus.
- **Pi hold-up / UPS — HELD POWER SAFETY / SPACE RESERVE.** Not selected or bought; reserve volume + a power tap so the Pi can be kept alive across a motor-rail cut (it must survive to write the receipt, B5).

---

## Commit conditions (Q-required — this doc self-certifies)

This artifact is committable because it states:
1. Datum is **`DRIVE_AXLE_FLOOR_DATUM`** (floor-contact plane, between drive wheels, on travel centerline) — not the shell center.
2. **(v1.2 revised)** Axis *convention* locked (X = fore-aft, Y = width, Z = vertical, not flipped); *magnitudes provisional*: 200/180 are footprint targets, and **Z = derived ~90 mm shell height — the 72 mm cap is killed** (it was an under-spec, not a constraint; receipt in A1.1).
3. **80 mm wheels are V1-locked and protrude through side cutouts** as real-envelope truth.
4. **Cliff lookahead >= 50 mm at <= 0.10 m/s**; above that speed → recompute + bench validation.
5. **Left/right downward ToF installed, center pocket reserved.**
6. **Fuse rating and E-stop placement are OPEN DECISIONS**, not mere arithmetic; **D4 fastener** still open. **(v1.2)** motor mount is now CLOSED (printed cradle).
7. **(v1.1)** This amendment **sharpens `60810ce`; it does not replace it.** No locked truth was moved. Added: `FRONT_MODULE_INTERFACE_DATUM` + cone-clearance rule; the explicit two-ToF safety non-claim; motor-mount method as an OPEN DECISION (with deck height gated under it); wire-channel and cliff-vertical measurables in COMPUTE; KB2040 / load-disconnect / Pi-UPS as held / space-reserve.
8. **(v1.2)** The body envelope is **provisional**, governed by the design hierarchy (physics/safety → work-on → assemble → service → durable → pretty-last). The envelope yields to physics/serviceability and records what it yielded to (receipt rule). Concrete results this revision: **72 mm cap killed**, height **derived ~90 mm** (A1.1), motor mount = **printed cradle**, **deck top ~57 mm**, **ground clearance 27.5 mm**. The ~90 is soft above the deck until the Pi-stack height and shell-wall thickness are measured.

## Bottom line

The footprint has a named datum (`DRIVE_AXLE_FLOOR_DATUM`), a locked axis convention, a safety-driven cliff offset, and a zone map — all referenced off one origin, all built from settled decisions. The cliff bay is locked as a bottom-plate feature with front-module windows. What remains is **OPEN COMPUTE numbers** (derivable, one of them gated) and **OPEN DECISION forks** that must be *decided*, not measured — plus **(v1.1)** held/space-reserve items that claim volume now. **(v1.1)** Two mis-files were corrected this pass: motor-mount method was promoted from arithmetic to an OPEN DECISION (deck height gates under it), and the cliff "number" was split into a plate-owned cone-clearance interface rule plus nose-side COMPUTE measurables. The architecture is closed; the remaining numbers and forks are not. CAD can begin laying out Part B zones; it may not finalize until the OPEN items close.

**Q lock:** *The datum is not the shell. The datum is where motion meets the floor. Start there.*

**v1.1 lock (Q):** *`60810ce` is the foundation. v1.1 does not move the datum. It adds the missing reservations, non-claims, and gated measurements.*

**v1.2 lock:** *The 72 mm cap is dead — it was inherited, not derived, and it proved an under-spec. Height is now computed from the floor up (~90 mm) with a receipt, and the envelope yields to physics. The motor mount is a printed cradle; deck top ~57 mm, ground clearance 27.5 mm. Compact where possible, accessible where necessary, safe always, pretty last.*

**Truth over comfort. The shell obeys the schematic. The plate obeys the wheels.**

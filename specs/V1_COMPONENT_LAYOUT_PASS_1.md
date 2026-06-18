# V1_COMPONENT_LAYOUT_PASS_1

> **Status:** first component-placement pass (nervous-system-first). NOT CAD-final, NOT a shell. A coordinate/zone map referenced off `DRIVE_AXLE_FLOOR_DATUM`, built from the locked footprint (`60810ce` → v1.1 `889c813` → v1.2 `0c8a198`) and the cradle/height decisions ratified this cycle. Drafted by Claude; **Q-audited** (5 fixes + 7 collision checks folded in below); awaiting Darrell ratification → commit.
>
> Tags: **LOCKED** (settled upstream), **PROPOSED** (this pass, defensible but open to ratification), **MEASURE** (needs a caliper number off the in-hand part before CAD), **OPEN DECISION** / **OPEN DESIGN** (a choice, not a number).
>
> **Placement hierarchy (Q-ratified) — every zone is judged against this, top down:** (1) LiPo access + safety; (2) motor/wheel/caster geometry; (3) cliff-sensor geometry; (4) power cutoff/fuse/service corridor; (5) Pi access + heat path; (6) sensor/logic routing; (7) shell protection. *Nervous system first; the skeleton obeys the parts.*

**Frame:** +X forward, +Y left, +Z up. Origin `DRIVE_AXLE_FLOOR_DATUM` = floor-contact plane, centered between drive wheels, on travel centerline. Working body envelope (provisional targets per v1.2): X ∈ [−100, +100] (200 fore-aft), Y ∈ [−90, +90] (180 width), Z ∈ [0, ~90] (derived shell).

**Reference planes (LOCKED / derived this cycle):**
| Z (mm) | Plane |
|---|---|
| 0 | floor / datum |
| 27.5 | motor belly (lowest point) |
| 40 | drive axle |
| 52.5 | motor top |
| ~57 | deck top (solid plate) |
| ~90 | shell top (provisional) |
| 29 | caster mount-to-floor height (MEASURED: #2692 = 29 mm overall) |
| 80 | wheel top (Ø80 wheel, sits below the ~90 shell) |

---

## 1. Required measured dimensions before CAD

CAD cannot finalize until these come off the **actual in-hand parts** (nominals shown are for this pass only):

1. **Pi 3 installed stack height** — standoff + board + tallest component (USB/Ethernet ~16 mm) + any HAT. Nominal ~25 mm. Sets the cabin and confirms ~90 shell. **The single biggest soft number.**
2. **#4885 faceplate** — the two M3 hole spacing + center-boss diameter. Sets the cradle face. Nominal: 25 mm body, boss + 2× M3 on a known small pattern — measure it.
3. **#4885 encoder backshell** — how far the encoder/cap protrudes past the 67 mm and its wire-exit face. Sets inboard motor clearance + wire exit.
4. **Wheel track (Y of faceplate)** — driven by the #3690 collet+hub stack width (how far the wheel seats off the shaft). Sets motor inboard reach and the central gap (§4.1). **OPEN COMPUTE in the footprint doc; this pass needs the collet stack measured.**
5. **Battery pack** — confirm the in-hand Zeee against nominal **75 × 34 × 26.5 mm** (shorty pack, soft case, XT60). Soft-pack swell margin: add ~1–2 mm.
6. **Top-shell wall thickness** (your choice) — closes the ~90 mm derivation.

Already measured/confirmed this cycle: **caster #2692 = 29 mm overall, 1″ ball, 3× M3 base**; motor body Ø25 × 67L, 4 mm D-shaft out 12.5 mm.

---

## 2. Proposed top-down component zones (X/Y ranges, from datum)

Read as a fore-to-aft sequence through the underside, then the cabin above.

**UNDERSIDE / BASEMENT (Z 0–57):**

- **Cliff bay (front).** PROPOSED X **+50 to +85**, set by the ≥50 mm lookahead (LOCKED). Pockets: L at Y +28 to +58, R at Y −28 to −58, **center reserved** Y −14 to +14 (blanked). Sensors VL53L4CD (~17×12), downward, rigid fixed-height mount (chassis-owned).
- **Front-mid (X +12 to +50): KEPT CLEAR.** PROPOSED. The battery is *forbidden* here — see §4.2 (CG/tip-forward). Reserved for wire routing + cliff-bay wiring rise.
- **Wheel line (X −12.5 to +12.5): MOTORS + WHEELS.** LOCKED axle X=0. Motor cylinders span Z 27.5–52.5, reaching inboard from the faceplate (Y ±~75) toward Y ±~8. Wheels Ø80 at the sides through cutouts (Z 0–80).
- **Mid-rear (X −13 to −47): BATTERY.** PROPOSED. Long axis along Y, Z ~3 to ~30 (low). Footprint 75 (Y) × 34 (X). Fore/aft trim slots to tune CG. Centroid ~**X −30** → inside the support triangle, lightly rear-biased (traction-positive). Aft edge held off the motor cylinders.
- **Rear (X −50 to −90): POWER / SERVICE CORRIDOR.** LOCKED zone. XT60, inline fuse (5–7.5 A blade, row 9/10), rocker switch (19×13 panel cutout, F4), reverse protector #5387, D24V22F5 buck. Reachable from the rear face without teardown.
- **Rear-center (~X −78, Y 0): CASTER.** PROPOSED. #2692, 3× M3. Mounts at Z=29 (see §4.3 — needs a ~28 mm reconciliation to the 57 deck).

**CABIN (Z ~57–90):**

- **Pi 3 (the dominant board, 85×56).** PROPOSED X −42 to +42, Y ±28, on M2.5 standoffs off the deck. Ports (USB/Ethernet, the tall edge) facing **−X (rear)** so cabling exits toward the service corridor. Clears wheel arches (Y ±77).
- **Electronics tier** — TB6612, KB2040, PCA9548 mux, ADS1115, BSS138 + band level-shift, 5-port hub, on Perma-Proto substrate beside/above the Pi. PROPOSED; exact placement after Pi stack height is measured (drives whether this tier is co-planar or stacked).

**RIDGE / FRONT-TOP (on/above shell, front):** camera centered, 2× VL53L4CD flanking, WS2812 LED band. Detailed in a later shell pass; here only its wire drops are reserved (§6).

---

## 3. Proposed Z-stack / layering

- **0–27.5:** wheels (sides), motor bellies, **battery** (Z 3–30, mid-rear), caster ball (rear).
- **27.5–52.5:** motor cylinders across the wheel line.
- **~53–57:** solid deck plate (the rigid safety datum; motors hang below it on cradles).
- **57–~84:** cabin — Pi on standoffs (~62 board, ~84 tallest component) + electronics tier.
- **~84–90:** thermal gap + top-shell wall.
- **>90:** ridge + reserved camera tilt envelope (v1.5).

The underside is **not flat**: deck at 57 across front/mid; the rear caster (29 mm) reaches the floor via a separate **height-tunable pod/shim**, not a one-shot plate step (§4.3).

---

## 4. Collision risks (attacked hard)

**4.1 — Motor-vs-motor at centerline.** Two 67 mm motors on a common axle in a ~180 mm body reach inboard to ~Y ±8, leaving a **~16 mm central channel** at the wheel line. Consequence: nothing wide lives low at X=0 — not the battery (34 wide), not a centered board. The basement center is *consumed by the motor sandwich*. **MEASURE wheel track (§1.4) — it directly sets this gap; if the collet stack pushes the wheels out, the gap shrinks further or the motors foul the frame.**

**4.2 — Battery-vs-motor, and the CG window (the central finding).** The battery (26.5 tall) sitting directly under the motors at X=0 puts its top at ~29.5 vs the motor belly 27.5 — a **~2 mm interference**. So it can't sit centered low at the axle line. Shifting it forward into the clear front-mid is **currently rejected on stability grounds**: it moves CG toward — and possibly ahead of — the support triangle, which risks a forward tip. **This is a design rejection pending proof, not settled physics** (Q correction): the exact no-tip line depends on real masses (Pi, shell, nose, motors, caster, wiring) and must be validated by a **mass mock-up / CG check before final CAD**. On that basis the battery is **placed in the aft window (X −13 to −47)**, CG ~X−30, inside the wheels↔caster triangle. PROPOSED. The fore/aft trim travels only within this aft window — it cannot cross the motor wall at X−12.5. (Cabin-mounting the battery was considered and rejected: it raises CG against F2 and steals Pi cabin volume; low-and-aft wins on CG.) **This is the tightest packaging constraint in the build.**

**4.3 — Caster height vs deck (the ~28 mm reconciliation).** Caster is 29 mm tall; its mount base sits at Z=29 to put the ball on the floor, while the deck is at 57 — a ~28 mm gap to bridge at the rear. Q split this correctly into two filings: the **shim height is MEASURE/COMPUTE** (caster contact height + shim stack, off the in-hand part), but the **physical bridge is OPEN DESIGN** — stepped rear plate vs separate caster pod vs bolted shim block vs printed replaceable shoe. **Q lean (and mine): a separate height-tunable caster pod/shim block, NOT a one-shot step baked into the safety plate** — it keeps the safety deck flat and stiff and lets ride height be tuned without reprinting a safety-critical part (cost: one added joint to keep tight). **Dependency note (Claude correction to the audit): deck height is gated by the cradle geometry; the caster pod is _downstream_ of the deck — it is sized to match whatever the deck turns out to be, not a gate on it.**

**4.4 — Wheel arches into the cabin.** Wheel top is 80; deck is 57. The wheels stand **23 mm above the deck plane** at the sides, so the cabin can't run full-width — wheel arches intrude at Y ±77 around X=0. The Pi (Y ±28) clears, but the electronics tier must not extend into the arches. PROPOSED arch keep-outs: Y beyond ±70 in the band X −20 to +20.

**4.5 — Cliff cone vs nose window.** Standing risk from v1.1 (A7): the cliff sensors are chassis-owned but their windows pass through the swappable nose. Every nose must clear the 18° cone unclipped. Layout consequence: the cliff bay (X +50–85, chassis) and the nose window apertures must be co-registered at the `FRONT_MODULE_INTERFACE_DATUM`. Flagged, governed by the existing interface rule.

**4.6 — Pi thermal (F15) — OPEN DECISION, not a shell afterthought.** Pi 3 in a ~27 mm enclosed cabin with the body sealed → throttle risk; ~6 mm over the tallest component is not enough air alone. Per Q, this is promoted from "shell later" to a **layout constraint now**. Reserve, at the layout level: a top vent path, a side vent path, a service hatch above the Pi, wire clearance above the GPIO/USB/CSI, and a minimum air gap over the tallest Pi component. **Air path first, heatsinks second** — the CanaKit heatsinks (row 42) are a supplement, not the solution. **OPEN DECISION — Pi thermal/service architecture.**

**4.7 — Checks to clear before commit (Q's seven).** None are resolved by this pass; each is a verification the CAD must satisfy:
1. **Battery strap vs basement wiring** — the strap must not crush encoder leads, motor leads, or the pack-sense divider.
2. **XT60 unplug room** — finger/hand clearance to pull it; a connector that needs needle-nose pliers is not serviceable.
3. **SD/USB vs Pi orientation** — a Pi placement that solves height but blocks the SD card fails the service rule (ties F14).
4. **Cliff-ToF cable bend radius** — front-underside STEMMA/Qwiic cables can't fold sharply into the plate.
5. **TB6612 heat + motor-wire exit** — driver wants short motor runs but must not be buried under the battery or Pi.
6. **Fuse access** — replaceable without removing the battery or the safety deck.
7. **Balance-lead / LiPo-alarm access** — the balance lead (alarm plug) must stay reachable after the battery is strapped in.

---

## 5. Service-access risks

- **Battery swap — the forced decision.** The battery is in the basement under the solid safety deck. It **cannot be reached without either pulling the deck (forbidden) or a dedicated access door.** The battery side/bottom door — previously deferred to v1.5 — is now **forced to a v1 decision**, because between-session swap + storage-charge (F3) is a routine operation and the design rule forbids removing the safety plate to service. **OPEN DECISION — V1-BLOCKING** (§7/§8).
- **Pi SD access (F14).** microSD is on the Pi underside edge; in the cabin under the top shell. Lifting the shell exposes the Pi, but the SD may need partial Pi lift. PROPOSED: orient Pi so the SD edge faces a shell access cut; confirm after Pi placement. Ties the F14 corruption mitigation (graceful LVC shutdown / read-only rootfs).
- **Rear corridor crowding.** XT60 + fuse + switch + #5387 + buck + the caster step all want rear volume. PROPOSED: caster on centerline, power components flanking it L/R, all reachable from the rear face. Risk: the rocker-switch panel cutout (F4) isn't yet in CAD.
- **E-stop.** External, cuts motor rail only, Pi stays alive (LOCKED behavior). Actuator type + placement **OPEN**; must land on the rear or a side reachable without opening the body.

---

## 6. Wire-channel routes

- **Cliff → mux → Pi:** from each front pocket (X+50–85, Z<57) up a protected channel through the front-mid clear zone to the PCA9548 (cabin), then to Pi I²C. STEMMA QT. Must not be pinched by a nose swap.
- **Motors → TB6612 + BSS138 → Pi/KB2040:** motor power + encoder leads from X=0 basement up into the cabin. **Keep motor-power runs away from the ADS1115 pack-sense and sensor I²C** (v1.1 B1 — motor noise corrupts pack-V reads).
- **Battery power chain:** XT60 (rear) → fuse → switch → #5387 → protected bus → buck → Pi. Short fat runs (≥20 AWG on the pack lead), all in the rear corridor.
- **LED band:** KB2040 (cabin) → 3.3→5 V level shift → band on the ridge (front-top). Long cabin-to-ridge run; route with the camera flex.
- **Camera:** Pi CSI → 610 mm flex (row 36) → ridge camera. Generous slack; route away from motor-noise.

---

## 7. Decisions still blocking CAD

**MEASURE — CAD-gating (numbers, off in-hand parts):** Pi stack height · #4885 faceplate hole spacing + boss · encoder backshell length · **wheel track (collet stack)** · battery dims confirm (75×34×26.5 + swell) · caster contact height + shim stack · wire-channel dims · **battery-door clearance**.

**COMPUTE (gated, not free):**
- **Deck height** — gated by the **cradle geometry** (the caster pod is *downstream* of this, not a co-gate; §4.3).
- **Battery CG** — requires a **physical mass mock-up / CG check before final CAD** (§4.2); the aft-window placement is accepted as current best layout, not proven.

**OPEN DECISION (a choice, not a number):**
- **Battery access door — V1-BLOCKING** (§5; was deferred to v1.5, now mandatory).
- **Pi thermal/service architecture** (§4.6, F15).
- **D4** plate-to-frame fastener (carried from footprint).
- **Fuse rating** (~5 A indicated by inventory rows 9/10; confirm vs wire gauge + stall).
- **E-stop actuator + placement** (§5).
- **Pi SD access strategy** (§5, F14).

**OPEN DESIGN (architecture, not yet drawn):**
- **Rear caster bridge** — pod / shim block / shoe (§4.3; Q lean: tunable pod, not a one-shot plate step).
- **Battery final X within the aft window** (CG trim; §4.2).

---

## 8. Q sign-off conditions (folded into this revision)

PASS_1 now carries these, per Q's audit, as the conditions for commit:
- **Battery access is V1-blocking.** The LiPo must be removable for charging, storage-voltage handling, inspection, and emergency removal **without removing the safety deck.** *(Q lock: any LiPo that can't be removed without disturbing the safety chassis is mounted wrong.)*
- **The aft-window battery placement** is accepted as current best layout but **must be validated by mass mock-up / CG check before final CAD.**
- **Rear caster height** requires a replaceable/tunable pod or shim strategy; do not bake a one-shot rear step into the whole plate until measured.
- **Pi thermal path and service access are layout constraints**, not shell afterthoughts.
- **CAD-gating measurements:** wheel track, collet stack, Pi stack height, motor boss geometry, encoder backshell, battery dims, wire-channel dims, and battery-door clearance.

---

## Bottom line

The basement is a **motor sandwich**: two long motors consume the wheel line and its center, placing the battery in a narrow aft window (X −13 to −47, CG ~X−30) — accepted as the best layout but **owed a mass-mock-up proof before CAD**, not asserted as physics. The 29 mm caster reaches the floor on a **tunable pod**, not a baked-in plate step. The battery's basement location makes the **access door V1-blocking** — a deferred decision the geometry promoted to mandatory. The Pi fits but needs a **designed air path**, not hope. None of this is CAD-final; it is a coordinate skeleton with every soft number flagged for the bench. **LiPo access first; the skeleton obeys the parts.**

*Cycle: Claude pass → Q audit (5 fixes + 7 checks, folded) → **Darrell ratify** → commit. One Claude amendment to the audit: deck height gates the caster pod, not vice-versa (§4.3).*

# V1_CRADLE_COUPON_REVA_RECIPE

> **Source authority:** `V1_CRADLE_SPEC_PASS_1.md` @ commit **`f6377c7`** (rev 2 — C_cup diametral, saddle = secondary support, anti-backward = L/R ID + keying). Every dimension here traces to that committed spec and to the measured values in `V1_CAD_GATE_MEASUREMENTS.md` @ `9ebee5f`.
>
> **Purpose:** a minimal **fit-test coupon** — establishes face flushness, boss clearance, screw alignment/access, saddle slip, encoder clearance, and service removal. It does **not** prove chassis strength and does **not** finalize track. Drafted by Claude → Q audit → Darrell ratify.

## 1. Coordinate system & datum

- **Origin O** = shaft axis, on the cradle's **datum face** (the motor-mating surface).
- **+Z = INBOARD** (motor face → body → encoder; the saddle runs this way).
- **−Z = OUTBOARD** (toward the wheel; shaft passes this way).
- **+X = UP** = the open side of the saddle trough (motor drops in from here).
- **Y** = horizontal; the two M3 holes lie on the Y axis at ±8.315.
- The datum face is the plane **Z = 0**; the motor's flat faceplate ring seats against it.

## 2. Parameter block

**Measured inputs (part truth — fixed, from `9ebee5f`):**
| name | value | source |
|---|---|---|
| `body_OD` | 24.79 | motor body OD |
| `boss_D` | 6.93 | center boss Ø |
| `boss_H` | 2.42 | center boss height |
| `hole_spacing` | 16.63 → `hole_offset` = 8.315 | M3 face holes |
| `silver_len` | ~52 | body length before encoder |

**Provisional printed parameters (coupon rev A starts — resolve on the printer):**
| name | value | note |
|---|---|---|
| `C_cup` | 0.35 **DIAMETRAL** | cup ID = body_OD + C_cup = **25.14** (0.35 total across Ø, ~0.175 radial gap) |
| `C_hole` | 3.4 | M3 through-hole Ø (screw passes free) |
| `D_pocket` | 0.40 radial | pocket Ø = boss_D + 2·D_pocket = **7.73** |
| `H_pocket` | 0.40 axial | pocket depth = boss_H + H_pocket = **2.82** |
| `T_plate` | 4.0 | face-wall thickness |
| `shaft_hole_D` | 5.0 | central through-hole for the 4 mm shaft |
| `saddle_len` | 22 | axial trough length (+Z) — short; leaves encoder open |
| `saddle_arc` | **180°** (coupon) | clean half-pipe; structural rev may go ~200° for capture |
| `saddle_wall` | 3.0 | trough wall thickness |
| `C_wire` | n/a (coupon) | rear open beyond saddle_len; encoder starts ~Z+52 |

## 3. Feature creation order (dependency order)

1. **Datum face wall.** A rounded rectangular plate, ~34 (Y) × 30 (X), from **Z = 0 to Z = −T_plate (−4)** — i.e., the wall is OUTBOARD of the motor face. Its **+Z face (Z = 0) is the datum** the motor seats against.
2. **Central shaft through-hole.** Ø `shaft_hole_D` (5.0), on the axis, through the full wall (Z 0 → −4). Lets the shaft pass outboard to the wheel.
3. **Boss clearance pocket.** Concentric with the axis, cut into the datum face (Z = 0) going **outboard (−Z)**: Ø `pocket_D` (7.73), depth `pocket_depth` (2.82). Recesses the boss so the flat faces meet. Leaves 4 − 2.82 = 1.18 of wall outboard of the pocket (the shaft hole continues through it).
4. **Two M3 through-holes.** On the Y axis at ±`hole_offset` (±8.315), Ø `C_hole` (3.4), through the full wall (parallel to Z). Clearance holes — threads engage the *motor*.
5. **Saddle trough.** A partial tube coaxial with the axis, extruded **inboard (+Z)** from the wall, from Z = 0 to Z = +`saddle_len` (+22). Inner Ø = cup ID **25.14**, wall `saddle_wall` (3.0) → outer Ø ~31.1. Arc = `saddle_arc` (**180°**, opening +X/up). Its outboard end is capped by the datum wall; the motor's front body section nests into it.
6. **L / R identification.** A recessed `L` (model this side as LEFT) on the outboard wall face.

**Where the saddle stops vs the encoder:** trough ends at Z = +22, far short of the silver body's ~52 and the encoder at ~52–66.5. The entire encoder cap, connector, and wire exit sit in open air beyond the trough — nothing to model, clearance is by absence.

## 4. Screw + intrusion calculation (Q#6)

```
intrusion = screw length − T_plate − washer stack ,  must be ≤ 6.00 under ALL tolerances
```
**Coupon rev A: M3 × 8 socket-head, no washer, through the 4.0 wall →**
- nominal intrusion = 8 − 4.0 − 0 = **4.0 mm** (good engagement, safe margin under 6).
- worst case (min-plate ~3.6 print): 8 − 3.6 = 4.4 mm — still ≤ 6 ✓.
- *(Do NOT use M3 × 10 here: at min-plate that's 10 − 3.6 = 6.4 > 6 — breaches the gear limit.)*

## 5. Mirror vs separately modeled (Q#10)

- **Model ONE cradle fully** (the LEFT, per step 6). The RIGHT is its **mirror** across the rover's fore-aft centerplane — not separately modeled.
- The `L`/`R` ID + the asymmetric saddle-open/wire-exit geometry make the mirror physically un-swappable (Q#3): a mirror part won't seat in the wrong mount.
- **For the fit coupon, print only ONE** — the fit is mirror-identical, so one part validates both hands.

## 6. Assembly order + wheel/track note (pressure-test finding)

- The datum wall + M3 screw heads sit **between the motor face and the wheel** (screws thread in from the outboard/wheel side). **Assembly order: seat motor in cradle → drive the 2 screws from outboard → THEN mount the wheel.** Screws are inaccessible once the wheel is on.
- Because the wall (≈4) occupies the outboard gap, the as-built wheel sits ~(T_plate − boss_H) ≈ **1.6 mm further outboard per side** than the boss-bottomed reference used for the 12.98 collet stack. **Track therefore nudges up from ~171 and stays provisional** — the coupon does not settle it; PASS_2 resolves track once plate thickness + wheel seating are fixed.

## 7. Print orientation & support (recommended; log actuals per spec §7)

- **Orient outboard wall-face DOWN on the bed, axis vertical**, so the **boss pocket + shaft hole + both M3 holes open upward** → clean, round, concentric (screw alignment is a pass/fail item, so hole quality matters). The 180° trough becomes a self-supporting vertical half-wall — **no internal support needed.**
- The datum (motor-mating) face is then a **top surface** — run an ironing / smooth-top pass, or accept minor texture; its flatness is itself one of the things the coupon evaluates (§8.1).
- Do not print with the two M3 holes horizontal (poor roundness → false screw-alignment fail).

## 8. Inspection steps — record pass/fail + notes for each

Print metadata REQUIRED before any `FIT_VERIFIED` (spec §7): printer · filament · nozzle Ø · layer height · orientation · slicer profile · coupon rev.

| # | Test | Method | Pass criterion | Result | Notes |
|---|---|---|---|---|---|
| 1 | **Face flushness** | seat motor face to datum wall | flat contact, no rock/gap | ☐ P ☐ F | |
| 2 | **Boss clearance** | check boss into pocket | boss seats, does NOT bottom; faces still meet | ☐ P ☐ F | |
| 3 | **Screw alignment + access** | drive 2× M3×8 into face holes | both start clean, reach, drivable | ☐ P ☐ F | |
| 4 | **Saddle slip** | body in trough | slides/seats, supports from below, no clamp/cock | ☐ P ☐ F | |
| 5 | **Encoder + wire clearance** | inspect rear | cap + connector + wires fully clear, unclamped | ☐ P ☐ F | |
| 6 | **Removal / reinstall** | unscrew, lift out, redo | motor out + back without cutting wires | ☐ P ☐ F | |

## 9. Open / next

- Run §8 → record. Any fail → adjust the §2 parameter(s) implicated, bump to **rev B**, reprint.
- On all-pass with metadata → tag `FIT_VERIFIED` and promote geometry toward the structural cradle (add capture arc ~200°, real skeleton interface, L/R keying) and feed the plate-thickness/wheel-seat back into the PASS_2 track resolution.

*Recipe traces to spec `f6377c7`. Parameters are printer-earned, not measured-copied. Face locates, saddle catches, rear stays open.*

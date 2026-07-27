# V1_CRADLE_PASS2_RECIPE

> **Source specification: `V1_CRADLE_SPEC_PASS_2.md` @ `05e382b`** (Q-signed-off, retention ratified).
> **This artifact is a PROTOTYPE. It is NOT `ROVER_INTERFACE_VERIFIED`.** It may earn `CRADLE_STRUCTURE_VERIFIED` on the rigid fixture only. `ROVER_INTERFACE_VERIFIED` cannot be earned until the cradle is mounted to the real skeleton / bottom plate.
>
> Drafted by Claude from the committed spec. Feature-by-feature, dependency order. Model: `cradle_pass2_proto.scad` (3 parts: cradle, strap, fixture).

## 1. Coordinate frame (same as Rev-A)
Origin = shaft axis on the datum face. **+Z inboard** (body/saddle), **−Z outboard** (wall/wheel), **+X up** (saddle opening / strap side), **−X down** (foot side), **Y** horizontal (M3 face holes on Y).

## 2A. INHERITED — Rev-A FIT_VERIFIED parameters (FROZEN — do NOT change)
Any change here **loses FIT_VERIFIED and requires renewed fit testing** (spec §5, Q#3).

| param | value | role |
|---|---|---|
| body_OD | 24.79 | motor body |
| boss_D / boss_H | 6.93 / 2.42 | center boss |
| hole_offset | 8.315 (16.63/2) | M3 face holes |
| cup_ID (`C_cup` 0.35 diametral) | 25.14 | saddle bore |
| C_hole | 3.4 | M3 through-hole |
| pocket_D / pocket_depth | 7.73 / 2.82 | boss pocket |
| T_plate | 4.0 | face wall |
| shaft_hole_D | 5.0 | shaft clearance |
| saddle_len | 22 | trough length |
| saddle arc | 180° | trough coverage |
| saddle_wall | 3.0 | trough wall |

**These reproduce the exact geometry that passed at `79badc6`. The prototype re-confirms them (§8.1) because new structure surrounds them.**

## 2B. NEW — Pass-2 structural parameters (tunable; retest on change)
| param | value | role |
|---|---|---|
| strap_gap | 1.0 | retention play — strap ceiling above motor |
| strap_boss_top | 4.0 | boss height above equator = the hard compression stop |
| strap_boss_Y | 17.0 | boss Y position (clear of motor + saddle) |
| strap_bar_w | 12 | strap width (Z) |
| strap_thick | 4.0 | strap material |
| strap_bolt_D | 3.4 | M3 clearance in strap feet |
| strap_insert_D | 4.2 | M3 heat-set insert bore in bosses (tune to your inserts) |
| foot_thick | 5.0 | base slab |
| foot_ear_Y | 28 | mount-ear Y (accessible from top) |
| foot_hole_D | 3.4 | M3 to fixture |
| block_halfY | 22 | cradle body half-width |

## 3. Compression-stop dimension chain (Q#4 — bolt torque CANNOT compress the motor)
The strap is an inverted-U. Its feet **bottom on the boss top faces** (solid structure). Its internal height sets the bar ceiling. The chain:

```
motor_radius        = body_OD/2                     = 12.395
strap_bar_underside = motor_radius + strap_gap      = 13.395   (fixed ceiling over the motor)
strap_boss_top      = 4.0                            (hard stop the strap feet bottom against)
strap_internal_h    = strap_bar_underside - boss_top = 9.395   (built into the strap part)
```
When the strap bolts are tightened, the feet bottom on the boss tops at X=+4.0 — a **rigid** stop. The bar underside is then fixed at X=+13.395, which is **strap_gap (1.0 mm) above** the motor top (X=+12.395). **Load path of bolt torque: strap → boss top → cradle block → foot → fixture. It never passes through the motor body.** Result: no achievable bolt torque can preload or clamp the 24.79 mm can.
**Record at assembly (spec §2):** designed clearance (1.0), compliant pad (none in proto), max bolt torque used, measured installed gap, and confirmation the motor still slips into the saddle with the strap installed.

## 4. Feature order (dependency)
**Cradle:** (1) main block → (2) motor bore (cyl r=cup_ID/2, Z 0→saddle_len) → (3) datum-face features: shaft hole, boss pocket, 2× M3 → (4) strap-mount bosses (+ insert bores) → (5) foot base + ears + mount holes → (6) molded `L` ID + keying notch (spec §1).
**Strap:** flat bar at bar_underside + two feet to boss tops + 2 bolt holes.
**Fixture:** rigid plate + 4 insert holes matching foot ears + 2 clamp slots (bench/vise) + wheel-load access clear on the −Z side.

## 5. Parts & mirroring
- **Cradle** — model the **LEFT**; **RIGHT is a mirror** across the fore-aft centerplane (not separately modeled). `L`/`R` ID + asymmetric keying carry over.
- **Strap** — symmetric; one design serves both hands.
- **Fixture** — one; serves either hand (prototype rig, not a rover part).
- **Print for the prototype: one cradle + one strap + one fixture.**

## 6. Witness-mark locations (Q#6 — molded flats for marker witness lines)
- **Across each of the 2 face screws:** a small flat spanning screw-head → cradle face (detect motor-face micro-rotation under torque).
- **Across the track/foot clamp:** a flat spanning foot ear → fixture (detect slip). *(Track indexing itself is deferred to the real-plate interface; the foot is a fixed pattern for the prototype.)*
- Marked in CAD as shallow flats; witness lines drawn with a marker before testing.

## 7. Print orientation & support (log actuals per spec §6)
- **Cradle:** datum face down on the bed (flattest mating face; preserves the FIT_VERIFIED face), axis vertical → bore + pocket + M3 holes print clean vertical, no internal support in the 180° trough. Strap bosses print upward.
- **Strap:** flat on the bed (bar face down), no support.
- **Fixture:** flat on the bed.

## 8. Prototype test — do these IN ORDER (fit + function BEFORE loads)
Record P/F + notes. Metadata required (printer/filament/nozzle/layer/orientation/profile/rev).

| # | check | pass criterion | result |
|---|---|---|---|
| 1 | Rev-A fit intact | face flush, boss seats, 2× M3 thread, saddle slip — all as `79badc6` | ☐ |
| 2 | install + removal w/ retention | motor in, strap on, motor out — no fight, no wire cut | ☐ |
| 3 | retention does NOT clamp | motor still slips; measured gap ≈ strap_gap; no preload | ☐ |
| 4 | skeleton attachment rigid | cradle bolts to fixture, no wobble | ☐ |
| 5 | wheel + tool clearance | wheel envelope + screwdriver access survive | ☐ |
| 6 | no load to encoder | cap + wires free in all of the above | ☐ |

## 9. Structural test → `CRADLE_STRUCTURE_VERIFIED` (spec §6 — AFTER §8 passes)
Run the 8 vectors from spec §6 on the fixture: vertical/lateral/fore-aft cantilever, **drive-torque reaction (externally applied — NOT via TB6612 stall)**, axial pull-out, retention separation, cycling, loaded encoder inspection. Each with magnitude/direction/point/duration/cycles/fixture/safety-factor/deflection limits. Witness marks read before/after. Set `F_lat` + torque + safety factor once rover mass + #4885 stall torque are pulled.

## 10. Open / next
- Tune §2B params on the first print (rev B loop, like the coupon).
- `F_lat`, torque target, safety factor, cycles — pending rover mass + stall torque.
- Skeleton-interface fastener pattern + track indexing — fixed when the real bottom plate exists (`ROVER_INTERFACE_VERIFIED` gate).

*Traces to spec `05e382b`. Frozen interface stays frozen; the strap can't clamp; the fixture stands in for a skeleton that doesn't exist yet. Prototype only.*

# V1_CRADLE_SPEC_PASS_2

> **What this is:** the structural cradle specification. It builds on the Rev-A coupon, which is **FIT_VERIFIED** at `79badc6` (dimensional compatibility proven). Pass 2 turns the proven fit into a mountable, serviceable, load-bearing cradle and defines a **separate structural gate**. Drafted by Claude; Q-audited (Pass-2 pressure brief folded in); for Darrell ratification → commit.
>
> **Two-gate model:**
> - `FIT_VERIFIED` — dimensional compatibility. **Already earned** for the Rev-A geometry (`79badc6`).
> - `STRUCTURE_VERIFIED` — survives bounded wheel/torque loads. **New gate, defined in §6.** Not yet earned.
>
> **Prime rule (Q#4):** any geometry changed from Rev A **loses automatic FIT_VERIFIED** and must be retested. Validated Rev-A parameters remain *evidence*, not a free pass.

## 0. Datum & load path (preserved)

- **Motor face = axial + rotational datum** (Q#1). The saddle must **not fight the face mount or preload the motor.** The face locates and carries; the body support catches.
- **Load path (Q#7, explicit):**

  `wheel → shaft / gearbox → motor face + secondary body support → cradle → skeleton`

  The **encoder cap and wiring are outside the structural path** — no load reaches them, ever.

## 1. Inherited & preserved constraints (frozen from Rev A — Q#6)

Carried forward unchanged; if a change forces one of these, it is flagged and retested:
- **2× M3×8** face screws, ~4 mm motor engagement, **≤6 mm intrusion** (gear limit).
- **Open encoder tail** — full clearance for the ~14.5 mm cap, connector, and wire bend radius.
- **Wheel envelope** — Ø80.30 + 8.78-wide tire + margin on the outboard side.
- **Molded L/R identification + asymmetric keying** (primary anti-backward).
- **Validated Rev-A slip params (evidence):** `C_cup` 0.35 diametral (ID 25.14), `C_hole` 3.4, boss pocket 7.73 × 2.82, `T_plate` 4.0, saddle arc **180°**, `saddle_len` 22 — *for the QIDI X-Plus 4 / PLA Rapido / 0.20 Standard profile.*

## 2. Retention approach — OPEN DECISION (Q#3)

Three approaches compared; selection on **serviceability, repeatability, and preserving the verified fit — not minimum part count.**

| approach | preserves verified fit? | serviceability | risk |
|---|---|---|---|
| **A. Proven 180° saddle + separate mechanical retention** (bolt-on upper strap/cap) | **Yes — slip surface untouched** | high (remove strap → lift motor) | extra part + 1–2 fasteners |
| B. Relieved / flexible over-center capture (>180°, snap-in) | **No — arc change, loses FIT_VERIFIED** | medium | can clamp the motor (kills the verified slip); flex fatigue |
| C. Removable upper strap or cap | Yes (same family as A) | high | same as A |

**Claude lean (for ratification): Approach A/C — keep the verified 180° saddle exactly, add a removable bolt-on upper strap as the retention.** Rationale: it leaves the FIT_VERIFIED slip surface *untouched*, so retesting is confined to the new strap + skeleton interface, not the proven motor fit. Approach B is rejected for Pass 2: it changes the arc (voids FIT_VERIFIED), and Q#2 is right that a rigid over-center arc risks converting the proven slip into a clamp. **Darrell ratifies.**

## 3. Saddle arc policy (Q#2)

**Do NOT auto-promote the ~200° capture arc.** The 180° arc is FIT_VERIFIED as a *slip*. Before any arc change, the **motor install/removal path must be defined**; a rigid over-center arc may turn the slip into a clamp or demand damaging flex. **Default: retain 180° and add separate retention (§2). Any arc change → re-enter the FIT gate.**

## 4. Skeleton interface — parameterized datum (Q#5)

The skeleton does not exist yet, so this interface is defined **parametrically**; values that depend on the bottom plate are placeholders until the plate/skeleton is drawn (forward dependency, flagged).

- **Fastener locations** — `SK_hole_x/y/pattern` (TBD vs plate); type/size TBD (likely M3 into heat-set inserts, per chassis standard).
- **Load direction** — primary is the wheel cantilever + drive-torque reaction into the skeleton; interface must react both.
- **Adjustment range** — `SK_adjust` slot range for track/toe trim (a few mm), so track can be tuned without reprinting (ties §7).
- **L/R mirroring** — interface mirrors with the cradle; keying prevents a cradle seating in the wrong-hand mount.
- **Anti-rotation** — the interface (not the slip saddle) resists the cradle rotating on the skeleton; **note: motor-vs-cradle anti-rotation is carried by the 2 face screws (torque couple across 16.63), NOT the slip saddle** — verify in §6.
- **Tool access** — skeleton fasteners reachable with the motor installed.
- **Wiring-safe removal** — cradle detaches from skeleton (and motor from cradle) **without disturbing the encoder wiring.**

## 5. FIT carry-over + retest rule (Q#4)

Rev-A FIT_VERIFIED covers the **motor-mating geometry only** (face, boss pocket, 2× M3, 180° saddle slip). It carries forward **only if those features are unchanged.** Anything altered — arc coverage, axial length, plate geometry, print orientation — **re-enters the FIT gate.** The Pass-2 prototype re-confirms Rev-A fit is intact (§8) precisely because new geometry surrounds it.

## 6. STRUCTURE_VERIFIED gate — bounded structural test (Q#8)

FIT_VERIFIED proves it fits; it does **not** prove it survives wheel loads. `STRUCTURE_VERIFIED` is earned only by a **bounded, defined** test (not FEA, not "seems sturdy"):

- **Setup:** Pass-2 cradle bolted to a fixed stand-in for the skeleton via the §4 interface; motor + wheel (or mass proxy at the wheel offset) installed; retention engaged.
- **Load 1 — cantilever/impact:** static lateral load at the wheel-contact offset = `F_lat` (target ~2–3× per-wheel static rover weight; value set once rover mass is estimated). **Pass:** deflection fully recovers (no permanent set), no crack.
- **Load 2 — drive-torque reaction:** apply torque to the shaft up to the #4885 stall torque. **Pass:** motor does **not** rotate in the cradle (face screws hold), no crack at the face, boss stays seated.
- **Load 3 — retention pull-out:** upward/pull-out load on the motor. **Pass:** retention holds the motor seated.
- **Encoder check (all loads):** **zero load reaches the encoder cap or wiring.**
- **Record (required for the tag):** printer · filament · nozzle · layer · orientation · profile · part rev · applied loads · results. No metadata / no defined loads → no STRUCTURE_VERIFIED.

## 7. Track status — provisional only (Q on track)

- Previous estimate: **~171 mm.**
- Current working estimate after the 1.6 mm outward shift per side (from the 4 mm face wall): **~174.2 mm.**
- **Neither is authoritative.** Track becomes measured or design-locked **only after** Pass 2 fixes: structural **plate thickness**, the **wheel seating plane**, and the **skeleton interface** — and the actual wheel-seating geometry exists together with the cradle. The §4 `SK_adjust` slot exists so final track can be trimmed physically. Until then: **~174.2 provisional.**

## 8. Pass-2 prototype scope (first print — Q#9)

The first Pass-2 print is a **prototype, not the final skeleton.** It must confirm:
1. Rev-A **fit remains intact** (face flush, boss, 2× M3, saddle slip).
2. **Installation + removal remain practical** (with retention).
3. **Retention does not clamp** the motor (still a slip, not a preload).
4. **Skeleton attachment is rigid.**
5. **Wheel + tool clearance survive** the added structure.
6. **No load reaches the encoder cap.**

(Structural loads per §6 come after the prototype confirms the above — fit and function first, then the load gate.)

## 9. Open decisions / next

- **Retention approach (§2)** — Darrell ratifies A/C vs B.
- **Skeleton interface values (§4)** — forward-dependent on the bottom plate; parameterize now, fix when the plate exists.
- **`F_lat` and stall-torque targets (§6)** — set once rover mass is estimated and #4885 stall torque is pulled.
- On ratification → Claude writes the **Pass-2 CAD recipe + prototype**, traceable to this committed spec.

*Face locates, body catches, retention holds, skeleton carries — encoder stays free. Fit is proven; strength is the next thing we earn, not assume.*

*Cycle: Claude draft → Q audit (folded) → Darrell ratify → commit → recipe.*

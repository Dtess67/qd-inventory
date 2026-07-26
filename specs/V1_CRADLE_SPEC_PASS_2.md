# V1_CRADLE_SPEC_PASS_2

> **What this is:** the structural cradle specification. Builds on the Rev-A coupon (**FIT_VERIFIED** at `79badc6`). Turns the proven fit into a mountable, serviceable, load-bearing cradle and defines the structural evidence gates. Drafted by Claude; **Q-audited twice** (Pass-2 pressure brief + Pass-2 audit, both folded — rev 2). For Darrell ratification → commit.
>
> **Evidence states (kept separate; a later gate never overwrites an earlier one):**
> - `FIT_VERIFIED` — dimensional compatibility + service fit. **Earned** for Rev-A geometry (`79badc6`).
> - `CRADLE_STRUCTURE_VERIFIED` — survives defined loads on a **controlled rigid fixture**, without unacceptable movement, damage, or encoder interference. New (§6).
> - `ROVER_INTERFACE_VERIFIED` — retested after attachment to the **real skeleton / bottom plate**. New (§6). A surrogate fixture never certifies the chassis.
>
> **Prime rule (Q):** a part can be structurally strong and dimensionally wrong, or fit perfectly and be weak. Changed geometry loses automatic FIT_VERIFIED and re-enters the fit gate. Structural results do not overwrite fit evidence.

## 0. Datum & load path (preserved)

- **Motor face = axial + rotational datum.** The saddle must not fight the face mount or preload the motor.
- **Load path:** `wheel → shaft / gearbox → motor face + secondary body support → cradle → skeleton`. The **encoder cap + wiring are outside the structural path** — no load reaches them.

## 1. Inherited & preserved constraints (frozen from Rev A)

Carried forward unchanged: 2× **M3×8** face screws (~4 mm engagement, **≤6 mm intrusion**), **open encoder tail** (~14.5 cap + connector + wire bend), **wheel envelope** (Ø80.30 + 8.78 tire + margin), **molded L/R + asymmetric keying**. Validated Rev-A slip params (evidence for the QIDI X-Plus 4 / PLA Rapido / 0.20 Standard profile): `C_cup` 0.35 diametral (ID 25.14), `C_hole` 3.4, boss pocket 7.73 × 2.82, `T_plate` 4.0, saddle arc **180°**, `saddle_len` 22.

## 2. Retention — SELECTED: 180° saddle + compression-limited strap (Q + Claude agree; Darrell ratifies)

Keep the verified 180° saddle **exactly** and add a **removable upper strap/cap** as separate retention. (Option B, over-center capture, rejected: changes validated cup geometry, introduces uncontrolled clamping, depends on orientation + fatigue, complicates removal, forces the fit gate to repeat across the whole interface.)

**The strap is retention, not a hose clamp (Q).** It **must** contain a **hard compression stop / fixed standoff**: the strap bolts bottom against structure *before* the strap can squeeze the 24.79 mm can. Concretely, the standoff sets the strap inner radius = (24.79/2) + designed clearance, so a fully-torqued strap still cannot preload the motor.

**Record (required):** designed strap-to-motor clearance · compliant pad used? (y/n) · maximum bolt torque · installed gap / compression-stop condition · **confirmation the motor still slides into the verified saddle without preload.**

## 3. Saddle arc policy

**Retain 180°.** Do not auto-promote a >180° capture arc; any arc change re-enters the FIT gate and risks converting the verified slip into a clamp.

## 4. Skeleton interface + alignment (parameterized)

### 4a. Skeleton interface (forward-dependent on the not-yet-existing bottom plate)
Parameters: fastener locations `SK_hole_*` (TBD vs plate; likely M3 → heat-set inserts) · **load direction** (reacts wheel cantilever + drive-torque reaction) · **L/R mirror** (keyed so a cradle can't seat wrong-hand) · **cradle anti-rotation on the skeleton** · **tool access** with motor installed · **removal without disturbing encoder wiring**.
*Note (Q-confirmed): motor-vs-cradle anti-rotation is carried by the **two M3 face screws** as a torque couple across the 16.63 spacing — the slip saddle is **not** credited with rotational resistance unless deliberate contact-under-deflection is measured.*

### 4b. Track-adjustment / alignment (filed here per Q — it creates *adjustment capability only*, it does NOT resolve track)
A plain slot + tightened bolts is insufficient — it makes a slip plane and a yaw-error path. Define: **hard reference datum** · adjustment direction · clamping surface area · washer / load-spreader geometry · anti-rotation feature · **method to keep L/R axles parallel** · **method to lock movement after track is set** · **witness marks** to detect slip. It must **not permit toe-in / toe-out or unequal axle Z**.
**Claude lean:** given FDM friction repeatability is poor, prefer a **fixed datum + indexed positions (or shims)** over a friction slot, unless the slot can be made repeatable and positively locked. *(Darrell/Q to decide.)*

## 5. FIT carry-over + retest rule

Rev-A FIT_VERIFIED covers the motor-mating geometry only (face, boss pocket, 2× M3, 180° saddle slip) and carries forward **only if unchanged.** New surrounding geometry means the Pass-2 prototype **re-confirms** Rev-A fit (§8). Structural testing is recorded in its own state and **does not overwrite** the fit evidence.

## 6. Structural gates + bounded test

**Torque method — NON-POWERED (Q correction):** do **not** prove the cradle by holding the motor at stall through the TB6612FNG — that conflates a structural test with driver-overcurrent + motor-heating, and the TB6612 margin is narrow. Instead apply an **externally measured tangential force at the wheel radius**, or a **mechanical torque fixture**. Target = **max credible drivetrain torque × safety factor**. A brief current-limited powered test may later confirm system behavior — not primary structural proof.

**Every test states:** load magnitude · direction · application point · duration · number of cycles · fixture · safety factor · max allowed temporary deflection · max allowed permanent set · pass/fail observations.

**Test vectors:**
1. Vertical cantilever load at the wheel-contact location
2. Lateral wheel load
3. Fore/aft wheel load
4. Drive-torque reaction (non-powered, per above)
5. Axial motor pull-out
6. Upward retention / strap separation
7. Repeated-load cycling
8. Encoder-cap + wire-clearance inspection **while loaded**

**Witness marks:** across **each screw head ↔ cradle face** (detect micro-rotation) and across the **track clamp** (detect slip).
**Anti-rotation inspection:** screw-head seating · material beneath screw heads · hole elongation · faceplate cracking · screw loosening · motor-face rotation.

**Pass requires:** no cracking / layer separation · no visible hole elongation · no screw rotation / loosening · no motor-face separation · no permanent axle-position shift beyond stated tolerance · motor remains removable · encoder cap unloaded · wiring unpinched · **Rev-A face-flushness + saddle-slip intact.**

**Two gates:** on the controlled rigid fixture → `CRADLE_STRUCTURE_VERIFIED`. Retested on the real skeleton/plate → `ROVER_INTERFACE_VERIFIED`. **Record for either:** printer · filament · nozzle · layer · orientation · profile · part rev · **applied loads** · results. No metadata / no defined loads → no gate.

## 7. Track status — provisional only

Previous ~171 → after the 1.6 mm/side outward shift, working estimate **~174.2 mm**. **Neither authoritative.** The §4b slot creates adjustment capability, not resolution. **Track becomes measured / design-locked only when the assembled left + right wheel contact centerlines are physically measured under the final locked interface.**

## 8. Pass-2 prototype scope (first print = prototype, not final skeleton)

Confirm, in order (fit + function before loads): (1) Rev-A fit intact · (2) install + removal practical with retention · (3) retention does **not** clamp (still a slip) · (4) skeleton attachment rigid · (5) wheel + tool clearance survive · (6) no load reaches the encoder cap. Structural vectors (§6) run after these pass.

## 9. Open decisions / next

- **Retention** (§2) — selected A/C by Q + Claude; **Darrell ratifies.**
- **Alignment method** (§4b) — indexed/shim vs locked slot.
- **Skeleton-interface values** (§4a) — forward-dependent on the bottom plate.
- **`F_lat`, torque target, safety factor, cycle count** (§6) — set once rover mass estimated + #4885 stall torque pulled.
- On amendments committed + retention ratified → Claude writes the **Pass-2 CAD recipe + prototype**, traceable to this commit.

*Face locates, body catches, strap holds (without squeezing), skeleton carries — encoder stays free. Fit is proven; strength is earned on a fixture, then re-earned on the real chassis.*

*Cycle: Claude draft → Q audit ×2 (folded) → Darrell ratify → commit → recipe.*

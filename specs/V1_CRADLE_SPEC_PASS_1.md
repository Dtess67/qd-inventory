# V1_CRADLE_SPEC_PASS_1

> **What this is:** the first spec for QD's printed motor cradle — a **fit-test coupon**, not the final structural chassis piece. Drafted by Claude; Q-audited (10 constraints + load path folded in); for Darrell ratification → commit. All dimensional inputs are the MEASURED values committed to `V1_CAD_GATE_MEASUREMENTS.md` at `9ebee5f`.
>
> **Prime directive (Q):** a measured component dimension is *part truth*, not a printed dimension. Every printed clearance below is a **PARAMETER** resolved by coupon test — never a silent copy of a measured number.

## 0. Architecture & load path

Face-mount. The **motor face is the datum** — it sets axial position and rotational orientation. The two M3 fasteners (into the motor's tapped faceplate holes) *retain* the motor. A shallow body **saddle** *supports* it against wheel-impact and cantilever loads. **The face locates; the saddle supports** — the saddle is NOT a press-fit clamp.

**Load path (Q-ratified):**

`wheel load → shaft / gearbox → motor-face fasteners + body saddle → internal skeleton`

The encoder tail cap and its wiring are **outside the structural path** — they carry no load and stay fully unclamped.

## 1. Measured inputs (part truth — from `9ebee5f`)

| Feature | Measured | Role in cradle |
|---|---|---|
| Motor body OD | 24.79 | saddle bore basis |
| M3 face-hole spacing | 16.63 | fastener datum (fixed) |
| Center boss | 6.93 Ø × 2.42 tall | clearance-pocket basis |
| Overall motor length | 66.51 (silver ~52 / encoder cap ~14.5) | saddle length + rear-open zone |
| Max screw intrusion into gearbox | 6.00 (HARD limit) | fastener-length calc |
| Shaft | 4 mm D, out 12.5 | wheel side — not gripped |

**These are part truths. None is a printed dimension.** §2 converts them to parameters.

## 2. Printed-clearance parameters (resolve by coupon — do NOT hard-code)

Every value below is a **starting guess for coupon rev A**, explicitly a parameter, not a finished dimension:

| Param | Meaning | Applied as | Coupon-A start | Locked? |
|---|---|---|---|---|
| `C_cup` | saddle radial clearance (slip, not clamp) | bore = 24.79 + 2·C_cup | +0.35 → bore ~25.5 | pending |
| `C_hole` | M3 through-hole clearance (screw passes free) | printed hole Ø | 3.4 | pending |
| `D_pocket` | boss pocket **radial** clearance | pocket Ø = 6.93 + 2·D_pocket | +0.40 → Ø ~7.7 | pending |
| `H_pocket` | boss pocket **axial** clearance | pocket depth = 2.42 + H_pocket | +0.40 → depth ~2.8 | pending |
| `C_wire` | wire-exit + bend-radius clearance | rear-open envelope | ≥ wire bend radius (TBD) | pending |

Why each matters:
- **`C_cup` is a slip fit, not a clamp (Q#2).** The saddle cradles the body; it does not squeeze it. Too tight and the saddle fights the face for axial/rotational control and can cock the motor off-datum.
- **The boss pocket needs BOTH radial and axial clearance (Q#5).** If the pocket is shallower than 2.42, the boss bottoms out and the flat faces never meet → flushness fails and the datum is lost. Depth must exceed boss height with margin; diameter must exceed boss Ø with margin.
- **`C_wire` (Q#3)** must let the connector seat, the bundle bend at ≥ its minimum radius, and the motor pull straight back out **without cutting wires**.

## 3. Fastener / screw-intrusion calculation (Q#6)

The 6 mm limit is **intrusion into the gearbox**, not nominal screw length. The spec computes intrusion, never assumes it:

```
screw intrusion = screw length − plate thickness (T_plate) − washer stack
CONSTRAINT : screw intrusion ≤ 6.00 mm under ALL tolerance conditions
TARGET     : useful thread engagement (aim 4–5 mm) without breaching 6.00
```

Worked example (parameters, coupon-A): with `T_plate` = 4.0 and a 0.5 washer, an **M3×10** gives intrusion = 10 − 4.0 − 0.5 = **5.5 mm** ✓. But `T_plate` is itself a parameter — a thin print raises intrusion. **Verify at worst case (min plate / max screw) before FIT_VERIFIED**, and prefer a screw length that stays < 6.00 even then.

## 4. Geometry — features

- **Face plate** — flat surface that mates to the motor's flat faceplate ring (the metal around the boss). This is the datum face. Thickness `T_plate` (feeds §3).
- **2× M3 through-holes** — on the **16.63 spacing (fixed)**, symmetric about the shaft/boss axis, Ø = `C_hole`. Clearance holes; the threads engage the *motor*, not the cradle.
- **Boss clearance pocket** — concentric with the shaft axis; Ø = 6.93 + 2·`D_pocket`, depth = 2.42 + `H_pocket`. Recesses the boss so the flat faces meet.
- **Body saddle** — partial-wrap cradle of the 24.79 body; bore = 24.79 + 2·`C_cup`. Wraps the **front (silver) portion only** — begins just aft of the face, spans a supporting length of the ~52 mm silver can, and **stops before the encoder cap.** Open-topped (partial wrap) for drop-in and service; NOT a full clamp.
- **Rear-open zone** — from the end of the saddle rearward: fully open. Clearance for the ~14.5 encoder cap, the connector, the wire bend radius (`C_wire`), and straight-back removal without cutting wires.

## 5. Handedness — mirrored L/R (Q#10)

The two cradles are **mirror images**, and the spec makes a backward install mechanically impossible. Each cradle drawing labels:
- **axle centerline** (Z 40.15) and **body datum** (motor-face plane)
- **inside face** (toward rover centerline) vs **outside face** (toward the wheel)
- **wheel-clearance envelope** on the **outboard** side (Ø 80.30 + 8.78-wide tire + margin)
- **encoder / wire exit** on the **inboard** side (toward centerline, into the wire channel)
- **motor-wire orientation** per side

Anti-backward: the wheel-clearance relief (outboard) and the wire-exit (inboard, rear) sit on **opposite sides**. A cradle installed backward would aim the wire exit outboard and foul the wheel envelope — visibly and mechanically wrong. If the coupon shows that isn't obvious enough by feel, add a small keyed/asymmetric datum notch.

## 6. This first artifact = FIT-TEST COUPON (Q#7)

Printed to **test fit**, not to carry the rover. It verifies:
1. Hole spacing (16.63) + screw access — can you actually drive the M3s?
2. Boss-pocket fit — motor face sits flush, boss does not bottom out
3. Motor-body saddle clearance — slips in, supports, does not clamp or cock
4. Face flushness — flat face fully contacts, no rock
5. Encoder-tail + wire clearance — nothing touches the cap; wires bend freely
6. Removal + reinstallation — motor comes out without cutting wires

## 7. FIT_VERIFIED gate (Q#8)

A result is recorded `FIT_VERIFIED` **only** with all of: printer · filament · nozzle Ø · layer height · print orientation · slicer profile · coupon revision · pass/fail result. No metadata → no FIT_VERIFIED. Clearances are printer- and filament-specific; a fit on one setup is not a fit on another.

## 8. Measured vs computed — do not blur (Q#9)

- **Measured (part truth):** everything in §1 — these drive the cradle geometry.
- **Computed / provisional:** track **~171 is NOT a measured rover dimension.** It is conditional on the 180 mm body width, flush faceplate placement, and the contact-line assumption. It does **not** enter the cradle; the cradle is built from the motor + boss + body, all measured.

## 9. Open / next

- Resolve §2 parameters on coupon rev A → record per §7.
- `T_plate` + screw length: confirm worst-case intrusion < 6.00.
- `C_wire`: needs the encoder connector + wire bundle in hand to set the bend radius.
- After FIT_VERIFIED: promote the coupon geometry to the structural cradle, then into bottom-plate integration (the deck-Z chain).

*Face locates, saddle supports, rear stays open. The parts are measured; the clearances are earned on the printer, not guessed.*

*Cycle: Claude draft → Q audit (10 constraints folded) → Darrell ratify → commit.*

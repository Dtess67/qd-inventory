# V1_CRADLE_COUPON_REVA_FIT_LOG

> Result log for the Coupon Rev A fit test. Traces to `V1_CRADLE_COUPON_REVA_RECIPE.md` and spec `V1_CRADLE_SPEC_PASS_1.md` @ `f6377c7`.

## Result: FIT_VERIFIED (2026-07-26)

Coupon Rev A, printed and tested against the actual #4885 motor. All six inspection steps pass, including the two hand-feel checks (screw thread-in, saddle slip) that a visual pass alone couldn't confirm.

### Print metadata (required for FIT_VERIFIED)
| field | value |
|---|---|
| printer | QIDI X-Plus 4 |
| filament | PLA Rapido (dried) |
| nozzle | 0.4 mm |
| layer height | 0.20 mm |
| profile | 0.20mm Standard @XPlus4 |
| coupon rev | A |

### Inspection results
| # | test | result |
|---|---|---|
| 1 | face flushness | PASS — flat, no rock |
| 2 | boss clearance | PASS — seats, no bottoming |
| 3 | screw alignment + thread-in | PASS — 2x M3x8 driven home, seated flat, shaft centered |
| 4 | saddle slip | PASS — slips/supports, no clamp |
| 5 | encoder + wire clearance | PASS — cap + wires hang free |
| 6 | removal / reinstall | PASS |

### Mounting hardware (confirmed)
- **2x M3x8 socket-head**, from the VGBUY M3 kit (inventory row 79).
- Bare #4885 ships with no screws (screws only come with the #2676 bracket, which was not purchased).
- Through the 4.0 mm cradle wall -> ~4 mm intrusion into the motor, safely under Pololu's 6 mm gear-clearance limit.

### Rev-A parameters (VALIDATED for this printer/filament/profile)
`C_cup` 0.35 diametral · `C_hole` 3.4 · `D_pocket` 0.40 · `H_pocket` 0.40 · `T_plate` 4.0 · `saddle_len` 22 · `saddle_arc` 180 deg.

## Next
- Rev A geometry is proven at fit level. Promote to the **structural cradle**: capture arc (~200 deg), skeleton interface, molded L/R ID + keying (spec section 5).
- Feed `T_plate` (4.0) + wheel-seat position into the **PASS_2 track resolution** (wheel sits ~1.6 mm outboard per side of the boss-bottomed reference; track nudges up from ~171, still provisional).

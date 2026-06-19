# V1_CAD_GATE_MEASUREMENTS

> **What this is:** a measurement gate. Every row is a physical number **CAD is forbidden to guess** — it must come off a manufacturer drawing (confirm), the in-hand part (calipers / scale), or be computed from one that did. NOT a design doc, NOT CAD geometry. It exists so no curve gets drawn around an assumed dimension.
>
> Built from the CAD-gating items in `V1_MASTER_FOOTPRINT_AND_BOTTOM_PLATE_CONSTRAINTS.md` (`60810ce`+) and `V1_COMPONENT_LAYOUT_PASS_1.md` (`5b7b7b3`). Drafted by Claude; for Q audit → Darrell ratify → commit.
>
> **Rule:** a dimension may not enter CAD until its row reads CONFIRMED ✓ (against drawing), MEASURED ✓ (off the part), or COMPUTE-resolved. **Calipers before curves — but read the drawing first.**

**Status legend:** `CONFIRM` published on a manufacturer drawing — verify your part matches · `MEASURED ✓` value already in hand · `MEASURE` no drawing exists, calipers required · `WEIGH` needs scale + mass mock-up · `COMPUTE` derived from other rows/decisions · `GATED` can't be taken until a named OPEN DECISION is made first.

**Source tags / drawings (pull these before the bench session):**
- `[PL-25D]` Pololu 25D gearmotor dimension diagram — https://www.pololu.com/product/4885 → "dimension diagram (PDF)"
- `[PL-3690]` Pololu 80×10 multi-hub wheel — https://www.pololu.com/product/3690
- `[PL-2692]` Pololu 1″ ball caster — https://www.pololu.com/product/2692
- `[PL-5387]` Pololu reverse-voltage protector — https://www.pololu.com/product/5387
- `[RPI3]` Raspberry Pi 3 B official mechanical drawing — https://datasheets.raspberrypi.com/rpi3/raspberry-pi-3-b-mechanical-drawing.pdf
- `[PL-3692]` Pololu VL53L4CD cliff ToF carrier — https://www.pololu.com/product/3692
- `[ADA-####]` Adafruit product page per breakout (5396 = forward/ridge ToF, 713 TB6612, 2858 buck, 5626 mux, 1085 ADS1115)
- `[ZEEE]` Zeee 2200mAh 3S listing (75×34×26.5, confirmed)
- `[BENCH]` no drawing can give it — measure/weigh on YOUR assembled build

---

## A. Drive — motor / cradle / wheels / track

| Measurement | Why CAD needs it | Tool / method | Status | Blocks | Source |
|---|---|---|---|---|---|
| #4885 faceplate: 2× M3 hole spacing + center-boss Ø | cradle bolt pattern + pilot bore | read diagram, confirm part | CONFIRM | cradle, deck Z | `[PL-25D]` |
| Cradle screw depth limit | bolts can't hit gears | drawing note: **≤6 mm into faceplate holes** | CONFIRMED ✓ | cradle bolt spec | `[PL-25D]` |
| #4885 body Ø + length (25 × 67) | cradle cup ID + inboard reach | diagram + confirm | CONFIRM | cradle, motor-sandwich gap | `[PL-25D]` |
| Encoder backshell length (~15 mm = 67L − 52L bare) | inboard clearance + motor-wire exit | diagram (encoder vs bare gearbox), confirm | CONFIRM | cradle rear clearance, wire channel | `[PL-25D]` |
| Shaft 4 mm D, extends 12.5 mm from faceplate | collet engagement + wheel offset | diagram | CONFIRMED ✓ | wheel track | `[PL-25D]` |
| **Collet stack width** (faceplate → wheel face), #3690 on shaft | sets **wheel track** + the ~16 mm center gap | assemble collet on shaft, **caliper** | **MEASURE** | **track, gap, side cutouts, plate** | `[BENCH]` |
| Wheel actual OD + width **with silicone tire** (nom 80 × 10) | side-cutout size, ground clearance, protrusion | **caliper assembled wheel** | MEASURE | cutouts, clearance, shell Z | `[BENCH]` / nom `[PL-3690]` |

## B. Battery + access

| Measurement | Why CAD needs it | Tool / method | Status | Blocks | Source |
|---|---|---|---|---|---|
| Battery L×W×H (75 × 34 × 26.5) | battery-well size | listing value, confirm pack | CONFIRM | well, basement | `[ZEEE]` |
| Battery **swell margin** (soft case) | clearance so an aged/charged pack still fits | add ~1–2 mm over measured | MEASURE | well clearance | `[BENCH]` |
| XT60 body + lead exit + **unplug finger room** | serviceable disconnect (Q #2) | caliper + hand test | MEASURE | corridor, well orientation | `[BENCH]` |
| Balance-lead length + plug + LiPo-alarm body | alarm reachable while strapped (Q #7) | measure lead + alarm | MEASURE | well, alarm access | `[BENCH]` |
| Strap path + strap width | strap must not crush wiring (Q #1) | layout test w/ strap | MEASURE | well, wire routing | `[BENCH]` |
| Battery-door aperture + removal direction | door opening + clearance arc | derive AFTER door-side chosen | **GATED** (battery-door decision) | battery door — V1-BLOCKING | `[BENCH]` post-decision |
| **Component masses + assembled CG** (mass mock-up) | proves battery final X / no-tip — *the PASS_1 §4.2 gate* | scale each part + balance mock-up | **WEIGH** | **battery final X, CG sign-off, PASS_2** | `[BENCH]` |

## C. Compute — Pi 3

| Measurement | Why CAD needs it | Tool / method | Status | Blocks | Source |
|---|---|---|---|---|---|
| Pi PCB 85 × 56 + M2.5 mounting-hole pattern | mount holes + cabin plan | drawing confirm | CONFIRM | Pi mount, cabin | `[RPI3]` |
| Pi connector Z-heights (**tallest = 16.0 mm**, USB/Eth) | cabin height, thermal gap | drawing confirm | CONFIRM | cabin/shell Z, thermal | `[RPI3]` |
| Pi port X/Y positions (USB / Eth / µUSB / HDMI / GPIO / CSI / **SD**) | service cutouts, **SD access** (Q #3) | drawing confirm | CONFIRM | orientation, hatch, SD cut | `[RPI3]` |
| **Installed stack height** (YOUR standoff + 1.4 board + 16 connector) | cabin/shell Z, deck-Z confirm | **caliper assembled w/ your standoffs** | **MEASURE** | cabin/shell Z | `[BENCH]` |
| Min air gap over tallest Pi component | thermal path (§4.6) | choose gap, confirm vs 16.0 | COMPUTE | Pi thermal architecture | `[RPI3]`+design |

## D. Cliff bay

| Measurement | Why CAD needs it | Tool / method | Status | Blocks | Source |
|---|---|---|---|---|---|
| VL53L4CD (Pololu #3692) cliff carrier L×W×H + mount hole | pocket size + fixed-height mount | product page confirm | CONFIRM | cliff-bay pockets | `[PL-3692]` |
| ToF cable exit + min bend radius (STEMMA/Qwiic) | cable can't fold sharp into plate (Q #4) | measure connector + cable | MEASURE | bay, wire channel | `[BENCH]` |
| Optical-window aperture + ToF-to-floor baseline | cone clearance + lookahead geometry | compute from FoV + mount Z | COMPUTE | bay, nose window, cliff-X | design |
| Cliff-X offset (≥50 mm lookahead point) | the rule → real plate X | compute from baseline + FoV + speed | COMPUTE | cliff-bay X, plate | design |

## E. Caster (rear support)

| Measurement | Why CAD needs it | Tool / method | Status | Blocks | Source |
|---|---|---|---|---|---|
| Caster #2692 overall height + 3× M3 base pattern | pod/shim height + mount holes | spec, confirm in-hand | **MEASURED ✓ (29 mm)** | caster pod | `[PL-2692]` |
| Pod/shim height = deck-Z − 29 | level deck (cradle → deck Z → pod → level check) | compute after deck Z resolves | COMPUTE | caster pod, level-deck verification | design |

## F. Power / service corridor

| Measurement | Why CAD needs it | Tool / method | Status | Blocks | Source |
|---|---|---|---|---|---|
| Board dims + connector heights: TB6612, buck, PCA9548, ADS1115, hub, shifters | electronics-tier packing + corridor | product pages, confirm | CONFIRM | cabin tier, rear corridor | `[ADA-713/2858/5626/1085]` |
| #5387 protector board dims | corridor placement | product page confirm | CONFIRM | rear corridor | `[PL-5387]` |
| Fuse holder + access clearance | replace w/o pulling battery or deck (Q #6) | measure holder + access path | MEASURE | corridor, fuse access | `[BENCH]` |
| Rocker switch body + 19×13 panel cutout (F4) | panel cutout missing from CAD | caliper KCD1-101 | MEASURE | rear/side panel, F4 | `[BENCH]` |

## G. Wire channels + frame fasteners

| Measurement | Why CAD needs it | Tool / method | Status | Blocks | Source |
|---|---|---|---|---|---|
| Wire-channel width/depth per bundle + min bend radius | channel sizing + strain relief | compute from bundle Ø + connector bend specs | COMPUTE | plate, core frame, channels | design |
| Heat-set insert (ruthex M3) boss Ø + depth | boss sizing for melt-in inserts | ruthex spec + test print | CONFIRM | all printed bosses | ruthex spec |
| M3 fastener head Ø + clearance (VGBUY) | counterbore / clearance holes | spec / caliper | CONFIRM | frame fasteners | VGBUY spec |
| Insert/boss edge wall thickness | wall around inserts won't split | **test print + measure** | MEASURE | core frame, plate | `[BENCH]` |

---

## What the drawings already settle (no bench time needed beyond a confirm)

Pulled this session, treat as CONFIRM-against-drawing, not blind measure:
- **Motor #4885** — body <25 mm Ø, 4 mm D shaft out 12.5 mm, 2× M3 faceplate holes, **≤6 mm screw depth** (gears), encoder backshell ~15 mm (67L − 52L bare). All on `[PL-25D]`.
- **Pi 3** — 85 × 56 PCB, standard M2.5 hole pattern, **tallest connector 16.0 mm**. All on `[RPI3]`.
- **Caster #2692** — 29 mm, 3× M3. `[PL-2692]`. **MEASURED ✓.**
- **Battery** — 75 × 34 × 26.5. `[ZEEE]`.

## What NO drawing can give you (true bench work)

1. **Installed Pi stack** — depends on YOUR standoffs, not Pi's drawing.
2. **LiPo swell** — soft-case packs grow; design clearance above the listed 26.5.
3. **Wheel OD with the silicone tire on** — molded tire runs off-nominal.
4. **Collet stack / wheel-face offset on your shaft** — the fit that sets track.
5. **Assembled masses + CG** — the PASS_1 mock-up; no drawing exists.
6. **Fit clearances** — XT60 finger room, cable bend radius in your channels, fuse-access path, boss wall thickness.

## Falsifier additions (not on the original list)

1. **Component masses + CG (§B, WEIGH).** Q's PASS_1 audit made battery final-X contingent on a mass mock-up, but the gate prompt omitted it. The single most load-bearing number CAD can't guess — it converts the aft-window battery from *proposed* to *proven*. Bridge to PASS_2.
2. **Wheel actual OD + width incl. tire (§A, MEASURE).** The list skipped the wheel's own outer dimension; silicone runs off-nominal and it sets cutout + clearance + protrusion at once.

## Dependency note (one item is not a pure measurement)

**Battery-door aperture is GATED, not MEASURE** — uncalipherable until the door-side / removal-direction decision (an OPEN DECISION, V1-BLOCKING) is made first. Filed gated so it isn't mistaken for a bench number waiting to be read.

## What this gate unblocks, in priority order

- **One #4885 bench session unblocks three things:** faceplate + boss → cradle spec; body/encoder → cradle clearance; **collet stack → wheel track → the whole motor-sandwich gap and the deck-Z chain.** Highest-leverage measurement in the build. (Most of the motor's own dims are already CONFIRM via `[PL-25D]` — the only true bench number here is the collet stack.)
- **The CG mass mock-up unblocks the battery's final position** and clears the PASS_1 §4.2 condition for CAD.
- **Installed Pi stack firms the cabin/shell Z** (the soft ~90).
- Everything else is parallel; none CAD-drawable until its row resolves.

*Calipers before curves — but read the drawing first. The gate holds the pencil back until the part has spoken.*

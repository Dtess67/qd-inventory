# QD V1 — Bill of Materials & Build-Completion Spec

**Purpose:** the single source of truth for what V1 *requires*, what is *in hand*, what must be *bought*, and what must be *decided* before the build is buyable in one trip. Cross-checked against the full inventory (93 rows) and flags roadmap (30 entries).

**Status:** working spec, not constitutional. Buy list is actionable; decisions block final order on a few items.

**Headline:** V1 is mostly *already bought*. The new-purchase list is short. The bigger risk is unmade **decisions** that gate the build, not missing parts.

---

## How to read this

Every line is tagged:
- **HAVE** — in hand, confirmed, allocated to V1.
- **BUY** — not owned (or not the right part); must order.
- **DECIDE** — a choice gates this; may or may not cost money.
- **CONFIRM** — owned but a count/spec/model is unverified; check before trusting.

---

## 1. Power & Safety

| Item | Status | Note |
|---|---|---|
| 3S 2200mAh LiPo (Zeee, XT60) ×2 | HAVE | 1 run + 1 swap. Store at 3.8V/cell. |
| Buck D24V22F5 5V 2.5A | HAVE | Holds 5V across full discharge. |
| Blade fuse 5–7.5A + inline holder | HAVE | Fuse upstream of switch (correct order). |
| XT60H connectors | HAVE / CONFIRM | Count from photo unconfirmed (Q1). Count the bag. |
| SPST rocker switch (KCD1) | HAVE | But placement not in CAD — see DECIDE D1. |
| SKYRC iMAX B6AC charger | HAVE | Bench. Storage mode habit. |
| LiPo low-voltage alarm buzzer (1–8S) | HAVE | ×4 in hand (Apex #1655, inv row 99). Independent balance-lead scream-box. |
| Pololu reverse-voltage protector, 4–60V 25A | HAVE | #5387 non-blocking, in hand (inv row 97). After fuse/switch, before bus branch. |
| **Inrush / soft-start** | **DECIDE/BUY** | Name as its own schematic block. Confirm whether the reverse protector's datasheet also covers inrush; if not, add a soft-start part. |
| **Hardware low-voltage LOAD-DISCONNECT (not a pack-building BMS)** | **DECIDE → BUY** | The real safety layer. Must be an inline discharge-path cutoff for a *finished RC pack*, NOT a cell-building 3S BMS. Exact part TBD. **Do not buy a generic "3S BMS / protection / 60A lithium" board.** |
| **Raspberry Pi UPS / 5V hold-up board (Pi 3)** | **DECIDE → BUY** | For graceful shutdown (F14). Buy only after a mechanical fit-check against Pi 3 + chassis. |
| Bulk electrolytic caps (decoupling) | HAVE | Inventory rows 88. Place at TB6612 VMOT, buck input, buck output, + local at sensor/logic. Verify rail noise on Hantek. |
| XT60 charge lead (charger ↔ pack) | CONFIRM / maybe BUY | F5: may not be in charger bundle. If absent, build from spare XT60H. |

**Power chain order (ratified):** XT60 → main fuse → main switch → reverse protection → inrush/soft-start → protected raw bus → {motor rail via E-stop→TB6612 VMOT} and {buck→5V→Pi/logic}.

**QD power rule (Q):** E-stop cuts *motor* power; it must NOT instantly kill the Pi. The Pi must stay alive long enough to write its last trace (the "receipt"). Ties the power tree to the Trace Obligation.

---

## 2. Drive

| Item | Status | Note |
|---|---|---|
| Pololu 4885 gearmotors + 48 CPR encoders ×2 | HAVE | Stall 0.9A. |
| TB6612FNG motor driver | HAVE | Survives stall with margin. |
| BSS138 4-ch level converter | HAVE | Resolves F1 (5V enc → 3.3V Pi). Pending wiring. |
| Ball caster | HAVE | 3rd contact point. |
| Wheels | HAVE / DECIDE | Owns Pololu 80mm wheels (3690) BUT locked design called for printed TPU wheels (D2). 80mm > 72mm body (F2). Decide printed-TPU vs bought-wheel before chassis finalize. |

**No drive parts to buy.** One decision (wheels) and one geometry flag (caster shim height vs axle, F2).

---

## 3. Compute & Storage

| Item | Status | Note |
|---|---|---|
| Raspberry Pi 3 | HAVE / CONFIRM | Model B vs B+ unconfirmed (Q5). |
| KB2040 (RP2040) co-processor | HAVE / DECIDE | Reflex Layer-1 + encoder counting + WS2812/I2S offload — or spare. Topology decision D3 (Pi+co-pro vs Pi-only). |
| microSD 32GB (Pi OS) | HAVE | Corruption-on-yank risk → F14 (hold-up + read-only rootfs). |
| Pi heatsinks (from CanaKit) | HAVE | F15: fit them; provide chassis airflow. |
| M2.5 standoff/screw kit (Geekworm) | HAVE / CONFIRM | 1 or 2 boxes? (Q2). Pi=M2.5, chassis=M3 → two fastener systems (F7/D4). |

**No compute parts to buy.** Decisions: compute topology (D3), fastener/mount method (D4), confirm Pi model (Q5).

---

## 4. Sensing — V1 core

| Item | Status | Note |
|---|---|---|
| Pi Global Shutter Camera + 6mm wide lens + 24in flex | HAVE | Core vision. Global shutter is deliberate (motion). |
| VL53L4CD **forward** ToF ×2 (Adafruit #5396) | HAVE | Ridge, flank camera. Both 0x29 → PCA9548 mux (F12). |
| VL53L4CD **downward cliff** ToF ×2 (Pololu #3692) | HAVE | Front-L/R underside, drop detection. Both 0x29 → mux. Received; logging as inv rows 96+. |
| BNO085 IMU | HAVE | Proprioception/tip detect (F2). Use UART-RVC or SPI (F10). 2nd unit = spare or ridge? (Q3). |
| PCA9548 I2C mux ×2 | HAVE | Resolves ToF address collision. |
| DS3231 RTC | HAVE | Timestamps significance. 2nd shares 0x68 → cannot share bus (F12). |
| Qwiic 5-port hub | HAVE | I2C fan-out for unique-address devices. |
| STEMMA QT cables (assorted) | HAVE | Deep stock (rows 19,20,37). |

**No core-sensing parts to buy.** Key call: keep V1 sensing minimal = camera + ToF + IMU (F8 warns against front-loading all ~10 modalities). Everything else → post-V1 plug-in library.

### Reflex-layer sensors (Layer-1, if KB2040 topology chosen — D3)
| Item | Status | Note |
|---|---|---|
| IR reflectance (cliff/edge) | HAVE | From 37-in-1 kit. **Now bench-only backup** — cliff resolved to dedicated VL53L4CD ToF (Pololu #3692); IR is not trusted V1 fall protection (F16). |
| Shock/tilt (impact/tip) | HAVE | From 37-in-1 kit / BNO085. |
| HC-SR501 PIR ×5 | HAVE / DECIDE | At-rest presence only, zero-velocity gated (F17). Array vs spares (Q6). Domes must be exposed → shell openings (F17/D5). |

---

## 5. Chassis, Fasteners & Print

| Item | Status | Note |
|---|---|---|
| Filament: PETG-Tough red, ASA gray, TPU, translucent black PETG | HAVE | Per locked materials. (Verify spool quantities sufficient for 4 modules + spares.) |
| ruthex heat-set inserts (M2/M3/M4/M5) | HAVE | M3 = workhorse. NOTE: no M2.5 → Pi still needs Geekworm M2.5 (F7). |
| M3 socket-head screw kit | HAVE | Chassis standard. |
| Perma-Proto boards ×6 | HAVE | Internal electronics substrate. |
| Hookup wire 22AWG silicone | HAVE | Consider 20/18AWG on pack +lead. |
| JST-XH connector kit | HAVE | Body-to-ridge bus (6-wire locked, F6/D6). |
| Heat-shrink kit | HAVE | Consumable. |
| Heat gun | HAVE | SEEKONE HG350 in hand (inv row 98). Heat-shrink + XT60 solder. (Heat-set inserts use a soldering iron.) |

**No buys here now (heat gun received).** Just confirm filament quantities.

---

## 6. The complete BUY list (one trip)

**Order now — safe, specced:**
*(All three cleared — now in hand, inventory rows 97–99.)*
1. LiPo low-voltage alarm buzzer — ✓ Apex #1655 ×4
2. Reverse-voltage protector — ✓ Pololu #5387 (non-blocking 25A)
3. Heat gun — ✓ SEEKONE HG350

**Order once decided (don't guess the part):**
4. **Hardware low-voltage load-disconnect** — inline discharge cutoff for a finished RC pack (NOT a cell-building BMS). Pin exact part first.
5. **Raspberry Pi 3 UPS / 5V hold-up board** — after mechanical fit-check.
6. **Inrush/soft-start part** — only if the reverse protector's datasheet doesn't already cover inrush.
7. **XT60 charge lead** — only if absent from charger bundle (else build from spares).

**Possibly:** extra filament if spool counts are short for all four modules + calibration + spares.

**Explicitly DO NOT buy:** any generic "3S BMS," "drill-pack protection board," or "60A 3S lithium board" — wrong class for a finished RC pack.

---

## 7. Decisions that gate the build (cost nothing, block progress)

| ID | Decision | Blocks |
|---|---|---|
| D1 | Switch placement (underside/rear vs intentional cue) — F4 | Top-shell print |
| D2 | Wheels: printed TPU vs Pololu 80mm — F2 | Chassis finalize |
| D3 | Compute topology: Pi + KB2040 co-pro vs Pi-only — F11 | Reflex layer, F9 resolution |
| D4 | Fastener/mount method (M2.5 inserts vs nut-capture) + standoff height — F7 | Bottom plate, hatch, cable routing |
| D5 | PIR dome openings in shell (if PIR in V1) — F17 | Shell design |
| D6 | Body-to-ridge bus topology (mux-in-ridge → 4-wire?) + connector — F6 | Ridge wiring |

**Recommended order:** settle D3 (compute topology) first — it cascades into reflex sensors, F9, and wiring. Then D2/D4 (chassis-finalizing). D1/D5/D6 can follow.

---

## 8. Open confirmations (quick checks)

- Q1: XT60H pair count (count the bag)
- Q2: Geekworm standoff kit — 1 or 2 boxes
- Q3: 2nd BNO085 — ridge or spare
- Q5: Pi 3 model B vs B+ (read silkscreen)
- T1: heat gun owned? — **YES** (SEEKONE HG350, inv row 98)
- Filament: enough for all four modules + calibration + spares?

---

## Bottom line

V1's parts are ~95% in hand. The alarm, reverse protector, and heat gun are now **in hand** — the remaining buys are just the 2–4 **decide-then-buy** items (load-disconnect, Pi UPS, inrush, charge lead). The real work before the build is the six **decisions** — none cost money, several block the print. Settle compute topology (D3) first.

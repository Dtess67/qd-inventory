# V1_SCHEMATIC_PASS_1

Text-first schematic plan for QD Rover V1. Drives shell layout constraints. **Bench truth before beauty. The shell obeys the schematic.**

---

## 1. Status and non-goals

- **Text schematic only.** Not CAD. Not a final wiring harness.
- **No calibrated thresholds.** Numbers below are part ratings and pack facts, not tuned setpoints.
- **No autonomy.** This plans the body and its safety, not behavior.
- **Not constitutional.** A working pass to be audited, revised, and bench-validated.
- **Purpose:** settle the electrical chain firmly enough to *derive shell zones*, so CAD obeys the schematic rather than the reverse.

Governing rule restated: power is never under-protected to save effort; the shell never dictates where a part goes if safety says otherwise.

---

## 2. System block diagram (text)

```
3S LiPo (Zeee, XT60)
  -> XT60 interconnect
  -> inline blade fuse (rating decision, see section 3)
  -> main rocker switch (SPST)
  -> reverse-polarity protection (ideal-diode/P-FET)
  -> soft-start / inrush block (decision: integral to protector or separate)
  -> PROTECTED RAW BUS  (~11.1V nominal, 12.6V full)
       |
       +-- [optional] hardware load-disconnect guarding the raw bus
       |
       +-- MOTOR RAIL --> E-stop (motor-only cut) --> TB6612FNG VMOT --> motors
       |
       +-- 5V BUCK (Pololu D24V22F5) --> Pi 3 / KB2040 / logic / sensor rails
       |
       +-- BATTERY SENSE --> voltage divider --> ADS1115 (Pi reads pack V)
       |
       +-- LiPo low-voltage ALARM via balance lead (independent, always-on)
       |
       +-- Pi HOLD-UP / UPS path on the 5V rail (graceful shutdown, F14)
```

Key invariant (from power-safety pass): **the E-stop cuts the motor rail, NOT the 5V/Pi rail.** The Pi must stay alive long enough to write its last trace. Motors die instantly; the brain dies gracefully.

---

## 3. Power + safety schematic pass

| Part | Status | Voltage | Current concern | Chain position | Connector/wire | Safety note | Open decision |
|---|---|---|---|---|---|---|---|
| Zeee 3S 2200mAh LiPo | HAVE | 11.1V nom / 12.6V full / ~9.0V empty | ~4A normal, motor stall transients | Source | XT60 (female on pack side) | Bare pack, NO onboard protection; store 3.8V/cell | — |
| XT60 interconnect | HAVE/CONFIRM | pack V | 60A rated, far above draw | Source -> fuse | XT60H solder-cup, fill for 22AWG | Keyed; can't reverse at connector | Q1: count pairs |
| Inline blade fuse + holder | HAVE | pack V | Protects WIRING, not silicon | After XT60 | ~16AWG holder leads, bracket to 22AWG bus | 5A or 7.5A only; never 15A+ (melts small wire) | **Fuse rating: 5A vs 7.5A** |
| Main rocker switch (KCD1) | HAVE | pack V | ~6A rated | After fuse | spade pigtails | Fuse UPSTREAM of switch (correct) | D1: placement (not in CAD) |
| Reverse-polarity protector | BUY | 4-60V | >=10A, prefer 20-25A | After switch, before bus branch | inline, 22AWG+ | Protects whole bus from reversed pack | Exact Pololu part |
| Soft-start / inrush block | DECIDE/BUY | pack V | limits inrush into buck caps | Same node as reverse protector | inline | Prevents contact pitting / nuisance fuse blow | Integral to protector datasheet, or separate part |
| Protected raw bus | (node) | ~11.1V | sum of all branches | Distribution point | soldered/Perma-Proto | Everything downstream is now protected | — |
| Pololu D24V22F5 buck | HAVE | in 11.1V -> out 5V | 2.5A out; Pi ~0.7-1A + LED band | Bus -> 5V rail | inline, decoupled | Holds 5V across full discharge (no brownout) | 5V rail budget (F13) |
| TB6612FNG driver | HAVE | VMOT to 13.5V (>12.6V OK) | 1.2A cont / 3.2A peak per ch; stall 0.9A OK | Motor rail -> motors | needs PWM x2, dir x4, STBY | STBY pin = a software stop path (distinct from E-stop) | — |
| Motor-only E-stop | DECIDE/BUY | motor rail V | full motor current | Between bus and VMOT | switch/relay rated > stall | Cuts motors, leaves Pi alive | **E-stop part + placement** |
| ADS1115 + divider | HAVE | reads scaled pack V | uA | Bus -> ADC | STEMMA QT / header | Enables software LVC + graceful-shutdown trigger (telemetry, not safety) | divider ratio |
| LiPo low-voltage alarm | BUY | 1-8S | uA | Balance lead | balance connector | Independent always-on scream-box; needs no brain | get x2-3 |
| Hardware load-disconnect | DECIDE->BUY | 3S | > stall current | Guards raw bus | inline discharge path | The REAL hardware LVC; cuts power without the Pi | **Finished-pack inline cutoff - NOT a cell-building BMS** |
| Pi hold-up / UPS | DECIDE->BUY | 5V | holds Pi ~seconds | On 5V rail | board-dependent | Graceful shutdown window (F14) | **Pi-3 mechanical fit-check first** |
| Bulk caps (electrolytic) | HAVE | rail V | absorb spikes | TB6612 VMOT, buck IN, buck OUT, local | soldered close to pins | Designed in, not bolted on after noise appears | verify on Hantek |

**Layered protection summary:** fuse (wire fire) -> reverse protector (polarity) -> soft-start (inrush) -> hardware load-disconnect (over-discharge, brain-independent) -> ADS1115 software LVC (graceful, telemetry) -> balance-lead alarm (audible, independent). Independent layers; no single point carries all the protection.

---

## 4. Compute / control schematic pass

**Pi 3 (HAVE):** main body agent - vision (CSI camera), logging, comms, the I2C sensor bus, ADS1115 pack-sense read, and the graceful-shutdown decision. Powered from the 5V buck on the rover (CanaKit USB supply is bench-only).

**KB2040 / RP2040 (HAVE):** *intended* reflex co-processor - fast body-side signals: encoder quadrature (PIO), WS2812 LED band (PIO, sidesteps F9 PCM collision), and direct dumb/fast reflex sensors (cliff/tilt).

**Pi <-> KB2040 link:** serial (UART) or I2C, KB2040 as a peripheral. Decision deferred, but the *physical* link (a few wires + connector) is reserved now.

**Signal placement:**
- **Lives on Pi day one:** camera (CSI), I2C sensor bus (ToF, IMU, ADS1115, RTC via mux/hub), pack-sense read, logging, comms.
- **Intended to move to KB2040:** encoder counting, WS2812 LED band, sub-100ms reflex inputs (cliff/tilt). *Reason to offload:* non-real-time Pi scheduler makes tight-timing tasks unreliable; the RP2040 PIO does them deterministically.
- **Reserved but NOT day-one required:** the entire KB2040 path. V1 first power-on and bench bring-up can be **Pi-only**.

**Pressure-test - Pi-only vs Pi+KB2040 (explicit, not silent):**
- *Pi-only is sufficient for first bench power-on and early bring-up.* The Pi can read encoders and drive the LED band slowly enough to validate the stack. This is the recommended day-one runtime.
- *Pi-only is NOT sufficient for the final reflex layer.* Sub-100ms hardcoded protection and clean WS2812 timing want the RP2040. Asking the Pi to do them long-term re-introduces F9 (PCM/LED collision) and timing jitter.
- **Therefore (CONFIRMED):** reserve KB2040 *physical space and connectors now*; run **Pi-only day one**; intend **Pi+KB2040 for the final reflex architecture**. "Physical layout reserved" != "runtime required." This is the split the prompt asked for, stated openly and now decided: build the body to accept the co-processor, bring up the brain without it, add it when the reflex code is ready.

**Serial / debug:** FT232RL USB-serial console into Pi UART (GPIO14/15) for headless bring-up - **jumper to 3.3V, Pi UART is not 5V-tolerant.** Zero network dependency.

**SD corruption / F14:** read-only rootfs and/or graceful shutdown triggered by ADS1115 pack-sense, backed by the Pi hold-up cap so the OS lands cleanly before power is gone. The SD module/logging-shield in inventory does NOT fix this (different bus) - it's a filesystem + power-timing fix.

---

## 5. Drive + encoder schematic pass

- **TB6612FNG (HAVE):** VMOT from motor rail (post-E-stop). Logic from 3.3V. Needs from controller: PWMA, PWMB, AIN1/AIN2, BIN1/BIN2, STBY. STBY is a software-disable distinct from the hardware E-stop.
- **Motors (HAVE):** 2x Pololu 25D 47:1 with 48 CPR encoders. Stall 0.9A (within TB6612). 4mm D-shaft.
- **Motor power path:** raw bus -> E-stop -> VMOT. Motor power NEVER routed through breadboard or logic rail.
- **Encoder power:** encoder Vcc 3.5-20V; outputs swing to Vcc. Run encoders at 5V.
- **BSS138 level shifter (HAVE):** 4-ch - 2 encoders x A/B. Encoder 5V outputs -> BSS138 -> 3.3V Pi/KB2040 GPIO. Resolves F1 (5V into Pi pin = damage).
- **Encoder A/B signals:** quadrature. **Day one:** Pi can read them (validation). **Intended:** KB2040 PIO counts them (deterministic, frees the Pi). Reserve the routing so either consumer works.
- **Motor noise / decoupling:** bulk cap at VMOT; keep motor wiring away from sensor bus; verify rail noise on the Hantek before trusting sensor readings during motion.

---

## 6. Sensor bus schematic pass

**Canonical V1 sensor set (locked):** camera, forward ToF, downward floor/cliff sensing, IMU, encoders, and battery voltage sense. Encoders (proprioception) and battery voltage sense (interoception) are first-class senses, not just drivetrain/power parts — she feels her own motion and her own energy state. Nothing beyond this list ships in V1 (F8).

- **Pi Global Shutter Camera (HAVE):** CSI ribbon (15-pin, 24in flex) -> Pi. Global shutter deliberate (moving robot, no rolling-shutter jello). Fragile flex - route, don't pinch.
- **VL53L4CD ToF x2 (HAVE):** both fixed addr 0x29 -> MUST sit on separate PCA9548 mux channels. Ridge-mounted, flank camera (forward distance).
- **Downward floor/cliff sensing (REQUIRED):** V1 MUST have downward sensing for cliff/edge detection before any rolling movement — this is a hard requirement, not optional. The 37-in-1 IR reflectance part is a **candidate only**, provisional until bench-confirmed or replaced with a better part. The requirement is locked; the specific sensor is not. Open decision: confirm-or-replace the part, and define mounting (front-lower zone). Build-blocking for safe motion.
- **PCA9548 mux x2 (HAVE):** resolves ToF collision; also isolates any other 0x68/0x29 colliders.
- **Qwiic/STEMMA 5-port hub (HAVE):** fan-out for unique-address devices (use hub for unique addrs, mux for colliders).
- **BNO085 IMU (HAVE):** tilt/tip detection (F2). **Known I2C clock-stretch trouble on Pi -> run UART-RVC or SPI**, or budget I2C bring-up time. Do not assume plain I2C works.
- **ADS1115 (HAVE):** pack-sense + any analog. Addr strappable.
- **DS3231 RTC (HAVE):** timestamps significance/decay. Fixed 0x68 - a 2nd RTC cannot share the bus (F12); one per bus or mux it.
- **I2C address map:** every device assigned to hub port or mux channel; colliders (2x ToF, 2nd RTC) explicitly separated. Build the address map before wiring.
- **Body-to-ridge connector:** locked 6-wire JST-XH (sensor signals only - **no servo PWM across the ridge joint**, per F6). JST-XH chosen over tiny JST-SH for the moving/flex joint (robust). Mux-in-ridge could collapse the run toward 4-wire I2C - open (D6).

---

## 7. Safety / reflex event contract

No final numeric thresholds. Each event tagged by where it lives.

| Event | Implementation | Notes |
|---|---|---|
| E-stop (motor cut) | **Hardware only** | Cuts motor rail; Pi stays alive |
| Lost link | Pi software (-> KB2040 later) | Comms watchdog -> safe stop |
| Tilt threshold | Pi software now; **KB2040 intended** | From BNO085; reflex-grade later |
| Floor absence / cliff | **KB2040 intended**, Pi-readable day one | From downward sensor; build-blocking for motion |
| Low voltage | Layered: hardware load-disconnect + Pi software (ADS1115) + balance alarm | Hardware is the real cutoff; software is graceful; alarm is audible |
| Motor command timeout | Pi software now; **KB2040 intended** | Dead-man on motion commands |
| Motor rail fault | Hardware (fuse) + future refinement | Over-current -> fuse; finer sensing later |
| Pi shutdown in progress | Pi software + hold-up cap | Hold-up buys the graceful window (F14) |

Reflex layer (sub-100ms) is *intended* for KB2040; day one these run on the Pi at coarser timing for validation only - explicitly not the final safety implementation.

---

## 8. Shell layout constraints derived from schematic (zones only, NOT a design)

- **Low center battery zone** - pack low and centered (CG, F2); the heaviest mass sets the rover's stability.
- **Rear / service access** - XT60, fuse holder, main switch reachable without disassembly (F4: switch placement still open).
- **Pi / service hatch** - top-shell hatch for Pi, SD access, and a heat path (F15: Pi 3 runs warm; needs airflow/vent).
- **Power distribution zone** - protected-bus node, buck, caps, reverse/inrush block grouped; short fat power runs.
- **Motor / wheel zones** - 2 drive wheels + caster; caster shim height vs axle for a level deck (F2). Wheel size vs 72mm body open (D2).
- **Front lower floor-sensor zone** - downward cliff sensor with clear line to the floor.
- **Front ridge zone** - camera centered, ToF flanking; ridge is directional, not a face.
- **Body-to-ridge cable path** - protected route for the 6-wire JST-XH (and flex-rated for v1.5 articulation).
- **E-stop physical access** - reachable, unambiguous; cuts motors only.
- **Ventilation** - vent path tied to the Pi heat zone.
- **Removable panels + strain relief** - every connector serviceable; wires strain-relieved; **no cramped stacking** (the schematic must fit with room to work).

---

## 9. Open decisions before CAD (ranked by build-blocking priority)

1. **Compute topology - CONFIRMED (D3).** Reserve KB2040 space + connectors; run Pi-only day one; intend Pi+KB2040 for the final reflex architecture. Decided. (Remaining layout work: route encoder/reflex signals so either consumer works.)
2. **Downward floor/cliff sensor - choice + mounting.** Build-blocking for *any* safe rolling movement. Confirm-or-replace the candidate part, define the front-lower zone.
3. **Hardware load-disconnect - finished-pack inline cutoff.** Pin the exact part (NOT a cell-building BMS). Shapes the protected-bus node.
4. **Fuse rating - 5A vs 7.5A.** Quick but real; sizes the protection.
5. **E-stop part + placement.** Motor-only cut; needs a physical home.
6. **Reverse-protection part.** Exact Pololu ideal-diode unit.
7. **Inrush / soft-start handling.** Integral to the protector, or a separate block.
8. **Pi hold-up / UPS candidate.** After Pi-3 mechanical fit-check.
9. **Body-to-ridge connector / topology (D6).** 6-wire JST-XH confirmed vs mux-in-ridge 4-wire.
10. **Pi mounting height / standoff method (D4).** M2.5 vs M3 reconciliation (F7).
11. **Battery placement / CG (F2).**
12. **Caster shim / wheel geometry (D2, F2).**

---

## 10. First bench tests driven by schematic (in order)

1. **Continuity / polarity** - DMM every power node before any power applied.
2. **Current-limited raw bus** - Tacklife bench supply (CC limit) standing in for the pack; never the LiPo first.
3. **Buck 5V validation with NO Pi** - confirm clean 5V before anything sensitive is connected.
4. **Pi power-up from buck** - Pi boots on rover power.
5. **Motor rail disabled** - verify motors stay dead with E-stop open / STBY low.
6. **E-stop motor cut with Pi alive** - trip E-stop; motors die, Pi keeps running (the core invariant).
7. **ADS1115 pack sense** - read scaled pack V; sanity-check against DMM.
8. **TB6612 dry spin on blocks** - wheels off the ground, low PWM.
9. **Encoder read through BSS138** - confirm A/B quadrature at 3.3V.
10. **Sensor bus scan** - I2C scan; confirm address map, mux channels, no collisions; bring up BNO085 in its non-I2C mode if needed.
11. **Floor / cliff sensor bench test** - validate downward sensing **before any rolling movement**.

Rolling movement is the *last* thing, only after cliff sensing works.

---

## 11. What NOT to buy / NOT to build yet

- No LiDAR. No GPS. No arm. No suspension. No second camera. No sensor flood - V1 sensing is the locked canonical set only (camera, forward ToF, downward cliff, IMU, encoders, battery voltage sense), nothing more (F8).
- No final shell before section 8 zones are settled and bench-validated.
- No autonomy.
- No word-claims - no "safe," "clear," "path." The forbidden-claims discipline applies here too.
- No cell-building 3S BMS / "60A lithium board" for the load-disconnect.

---

## 12. Final recommendation

- **V1 schematic pass ready for Q audit:** YES. The chain is complete, layered, and inventory-true; every part is placed; the Pi-only-vs-KB2040 split is explicit, not silent.
- **Darrell can start buying the small power/safety parts:** YES for the unambiguous ones - LiPo alarm buzzer (x2-3), reverse-polarity protector (pin the exact Pololu part), heat gun if not owned. HOLD on the load-disconnect, Pi hold-up, and inrush part until their decisions (section 9 #3, #7, #8) are pinned - those are "decide then buy," not guesses.
- **Shell constraints ready to hand to CAD:** ZONES yes (section 8), final geometry no. CAD may lay out zones; it may not finalize until the downward-sensor zone is settled.
- **Single next decision:** **downward floor/cliff sensor — confirm-or-replace the candidate part and define its front-lower mounting zone.** With compute topology now confirmed (reserve KB2040, Pi-only day one), the cliff sensor is the top remaining build-blocker: she cannot safely roll until she can see an edge. Settle it and the front-lower shell zone unlocks.

**Truth over comfort. Bench truth before beauty. The shell obeys the schematic.**

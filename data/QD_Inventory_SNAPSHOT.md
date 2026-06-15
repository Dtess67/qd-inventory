# QD Electronics Inventory — text snapshot (2026-06-14)

Plain-text fallback of the master spreadsheet. If the .xlsx ever won't open, this and the CSVs hold the same data.

**Totals:** 93 inventory line items · 29 flags/questions

**Latest summary:** Bench instruments: Tacklife MDC02 DC supply (CC limit = safe first power-on; develop OFF the LiPo; verify ~5A ceiling vs motor stall) + Hantek DSO5102P 2ch 100MHz scope (signal-integrity debug for F1 encoder / F9 WS2812 / F10+F12 I2C / F13 rail noise / F18 PWM). With the DMM = full diagnostic trio (meter/supply/scope).

## Inventory

### 1. Raspberry Pi 3  —  [Committed: QD v1]
- **Qty:** 1 board · **Subsystem:** Compute · **Mfr/Part:** Raspberry Pi 3
- **QD verdict:** Core
- **Notes:** CanaKit Complete Starter Kit (32GB). Model B/B+ - confirm (Q5). ~26 usable GPIO; I2C/SPI/I2S/PWM. Comes OUT of CanaKit case -> M2.5 standoffs (F7). Enclosed-body heat -> F15. SD-corruption on power-loss -> F14.

### 2. Pi Global Shutter Camera (wide-angle)  —  [Committed: QD v1]
- **Qty:** 1 unit · **Subsystem:** Sensing · **Mfr/Part:** Raspberry Pi GS
- **QD verdict:** Core
- **Notes:** Global Shutter, CS-mount (PID 5702). 6mm wide lens + 24in flex now logged separately. Confirmed.

### 3. ToF distance sensor VL53L4CD  —  [Committed: QD v1]
- **Qty:** 2 unit · **Subsystem:** Sensing · **Mfr/Part:** Adafruit 5396 (VL53L4CD)
- **QD verdict:** Core
- **Notes:** STEMMA QT breakout, ~1-1300mm. Both addr 0x29 -> isolate via PCA9548 mux. Ridge-mounted, flank camera.

### 4. 47:1 Metal Gearmotor 25Dx67L LP 12V, 48 CPR encoder  —  [Committed: QD v1]
- **Qty:** 2 unit · **Subsystem:** Drive · **Mfr/Part:** Pololu 4885
- **QD verdict:** Core
- **Notes:** 12V LP, stall 0.9A, free-run 60mA. 4mm D-shaft. Enc: 2248.86 cts/output-rev. ENCODER Vcc 3.5-20V, outputs swing to Vcc — see Flag F1.

### 5. Multi-Hub Wheel 80x10mm, 3/4mm inserts, black  —  [Committed: QD v1]
- **Qty:** 2 wheel (1x 2-pack) · **Subsystem:** Drive · **Mfr/Part:** Pololu 3690
- **QD verdict:** Core — verify vs TPU plan
- **Notes:** 4mm insert fits motor shaft. 80mm dia > 72mm body height — see Flag F2. Locked design called for printed TPU wheels.

### 6. TB6612FNG Dual Motor Driver Carrier  —  [Committed: QD v1]
- **Qty:** 1 board · **Subsystem:** Drive · **Mfr/Part:** Pololu 713
- **QD verdict:** Core
- **Notes:** 1.2A cont / 3.2A peak per ch. Survives 0.9A LP stall. VMOT max 13.5V > 12.6V pack OK. Needs PWMx2+4 dir+STBY GPIO.

### 7. Ball Caster, 1in plastic ball + bearings  —  [Committed: QD v1]
- **Qty:** 1 unit · **Subsystem:** Drive · **Mfr/Part:** Pololu 2692
- **QD verdict:** Core
- **Notes:** 3rd contact point -> differential drive. Caster+shim height must match wheel axle for level deck — see Flag F2.

### 8. D24V22F5 — 5V 2.5A Step-Down Regulator  —  [Committed: QD v1]
- **Qty:** 1 board · **Subsystem:** Power · **Mfr/Part:** Pololu 2858
- **QD verdict:** Core
- **Notes:** Buck for Pi/logic 5V rail. Input from 3S pack stays >5V across full discharge — no brownout.

### 9. Blade fuse assortment (ATO/ATC), 120pc  —  [Committed: QD v1]
- **Qty:** 1 kit · **Subsystem:** Power · **Mfr/Part:** Generic
- **QD verdict:** Core (5-7.5A); rest spare
- **Notes:** 5/7.5/10/15/20/25/30A. QD main fuse = 5A or 7.5A. 15A+ would pass enough to melt small wiring — do not use.

### 10. Inline blade fuse holder, ~16AWG leads  —  [Committed: QD v1]
- **Qty:** 10 unit · **Subsystem:** Power · **Mfr/Part:** Generic ATO
- **QD verdict:** Core (x1); 9 spare
- **Notes:** One installed in pack +lead. Standard ATO size. ~16AWG leads vs 22AWG bus — bracket both in crimp.

### 11. XT60H connectors, M+F, w/ insulating caps  —  [Committed: QD v1]
- **Qty:** 10 pair (tentative) · **Subsystem:** Power · **Mfr/Part:** Generic XT60H
- **QD verdict:** Core (x1); spare
- **Notes:** COUNT UNCONFIRMED. 60A rated (>>4A draw). Solder-cup — fill cup for 22AWG. Female on battery side.

### 12. Zeee 3S 2200mAh 50C LiPo (XT60)  —  [Committed: QD v1]
- **Qty:** 2 pack · **Subsystem:** Power · **Mfr/Part:** Zeee
- **QD verdict:** Core (x1 + swap/spare)
- **Notes:** 11.1V nom / 12.6V full / 24.42Wh. Ships XT60 (matches XT60H). STORE at 3.8V/cell between sessions. See Flags F3 (runtime LVC) + F2 (CG).

### 13. SKYRC iMAX B6AC V2 balance charger/discharger  —  [Bench equipment]
- **Qty:** 1 unit · **Subsystem:** Power / Support · **Mfr/Part:** SKYRC
- **QD verdict:** Support equip (off-board)
- **Notes:** AC/DC, 6A chg / 2A dischg, LiPo 1-6S. Balances 3S. Has STORAGE mode (3.8V/cell). Charge 3S at ~2.2A (1C), not 6A. Needs XT60 charge lead — see Flag F5.

### 14. DaierTek KCD1-101 SPST rocker switch + spade pigtails  —  [Committed: QD v1]
- **Qty:** 10 unit · **Subsystem:** Power / Control · **Mfr/Part:** DaierTek KCD1-101
- **QD verdict:** Core (x1); 9 spare
- **Notes:** ~6A. On/off between runs (saves XT60 cycles). Needs ~19x13mm panel cutout NOT in locked CAD — see Flag F4. Wire: fuse upstream of switch.

### 15. Fermerry 22AWG stranded silicone hookup wire, 6 colors  —  [Committed: QD v1]
- **Qty:** 150 ft (25ft x6) · **Subsystem:** Wiring · **Mfr/Part:** Fermerry
- **QD verdict:** Core
- **Notes:** Silicone = good for v1.5 ridge flex. 22AWG fine everywhere; thinnest acceptable on pack +lead (consider 20/18AWG there).

### 16. JST-XH 2.54mm connector kit (2P-10P) + pre-crimped silicone leads  —  [Committed: QD v1]
- **Qty:** 1 kit · **Subsystem:** Wiring · **Mfr/Part:** elechawk
- **QD verdict:** Core
- **Notes:** Body-to-ridge bus connector family. Inherently keyed. 6P = locked spec; 8P available if upsizing — but mux may collapse to 4-wire I2C. See Flag F6.

### 17. Heat-shrink tubing kit, 2:1, 1-8mm, 580pc  —  [Committed: QD v1]
- **Qty:** 1 kit · **Subsystem:** Wiring · **Mfr/Part:** Ginsco
- **QD verdict:** Core (consumable)
- **Notes:** -55 to +125C. Non-adhesive. Needs a HEAT GUN, not a lighter — confirm one is owned (tool note).

### 18. M2.5 brass standoff/screw/nut kit, 100pc  —  [Committed: QD v1]
- **Qty:** 2 kit (tentative) · **Subsystem:** Compute / Mounting · **Mfr/Part:** Geekworm
- **QD verdict:** Core
- **Notes:** COUNT TENTATIVE (1 open + 1 sealed). M2.5 = Pi standard (chassis is M3 — two fastener systems). Mount method undecided — see Flag F7.

### 19. STEMMA QT JST-SH 4-pin to male header cable  —  [Committed: QD v1]
- **Qty:** 4 cable · **Subsystem:** Wiring / Sensor · **Mfr/Part:** Adafruit 4209
- **QD verdict:** Core
- **Notes:** Breaks STEMMA QT I2C out to header pins (e.g. to Pi).

### 20. STEMMA QT / Qwiic JST-SH 4-pin cable, 150mm  —  [Committed: QD v1]
- **Qty:** 4 cable · **Subsystem:** Wiring / Sensor · **Mfr/Part:** Adafruit 4397
- **QD verdict:** Core
- **Notes:** Plug-and-play I2C chaining. JST-SH (1.0mm) — small; NOT ideal for flex joint vs JST-XH. See Flag F6.

### 21. PMSA003I Air-Quality (PM2.5) sensor, STEMMA QT  —  [QD v1.5+ / reusable]
- **Qty:** 1 unit · **Subsystem:** Sensing · **Mfr/Part:** Adafruit 4632
- **QD verdict:** Later (v1.5+)
- **Notes:** I2C particulate sensor — new environmental modality. Scope question vs locked v1 — see Flag F8.

### 22. PCA9548 8-channel I2C multiplexer, STEMMA QT  —  [Committed: QD v1]
- **Qty:** 2 board · **Subsystem:** Sensing / Infra · **Mfr/Part:** Adafruit 5626
- **QD verdict:** Core (infrastructure)
- **Notes:** Resolves ToF 0x29 address collision. One in ridge can collapse body-to-ridge run to 4-wire I2C. See Flag F6.

### 23. Magnetic reed contact switch, SPST-NO w/ leads  —  [QD v1.5+ / reusable]
- **Qty:** 4 unit · **Subsystem:** Sensing · **Mfr/Part:** Adafruit 375
- **QD verdict:** Later / TBD
- **Notes:** Reed + magnet (NOT vibration sensor). Possible use: swappable front-module presence/keying, or hatch sense. Confirm intent.

### 24. BNO085 9-DOF Orientation IMU (fusion)  —  [Committed: QD v1]
- **Qty:** 2 board · **Subsystem:** Sensing · **Mfr/Part:** Adafruit 4754
- **QD verdict:** Core (x1) + 2nd TBD
- **Notes:** Proprioception — addresses tip-over (F2). Known Pi I2C clock-stretch issue: use UART-RVC/SPI — see Flag F10. 2nd unit: body+ridge or spare? (open Q).

### 25. SPH0645LM4H I2S MEMS microphone  —  [QD v1.5+ / reusable]
- **Qty:** 2 board · **Subsystem:** Sensing · **Mfr/Part:** Adafruit 3421
- **QD verdict:** Later (v1.5+)
- **Notes:** AUDIO via I2S (not I2C) — separate Pi bus/GPIO. Two = stereo. PCM peripheral conflicts w/ WS2812 LED — see Flag F9.

### 26. Adafruit KB2040 (RP2040) co-processor  —  [Committed: QD v1]
- **Qty:** 1 board · **Subsystem:** Compute · **Mfr/Part:** Adafruit 5302
- **QD verdict:** Core? (decision)
- **Notes:** RP2040 MCU (free w/ order). Candidate real-time co-pro: Layer-1 reflex (deterministic), PIO quadrature for encoders, PIO WS2812 (sidesteps F9), I2S. Architecture decision -> Flag F11.

### 27. BSS138 4-ch I2C-safe logic level converter  —  [Committed: QD v1]
- **Qty:** 1 board · **Subsystem:** Wiring / Infra · **Mfr/Part:** Adafruit 757
- **QD verdict:** Core
- **Notes:** RESOLVES F1. 4 ch = 2 encoders x A/B. Encoder Vcc 5V -> BSS138 -> 3.3V Pi.

### 28. ADS1115 16-bit 4-ch ADC (PGA)  —  [Committed: QD v1]
- **Qty:** 2 board · **Subsystem:** Sensing / Infra · **Mfr/Part:** Adafruit 1085
- **QD verdict:** Core (1)
- **Notes:** Adds analog input to Pi (Pi has none). Enables F3: read pack V via divider for runtime low-voltage cutoff. Addr 0x48-0x4B strappable (2 coexist).

### 29. BME688 temp/humidity/pressure/gas sensor  —  [QD v1.5+ / reusable]
- **Qty:** 1 board · **Subsystem:** Sensing · **Mfr/Part:** Adafruit 5046
- **QD verdict:** Later (v1.5+)
- **Notes:** Environmental: gas/VOC + T/H/P. Complements PMSA003I (particulate). I2C STEMMA QT. Scope -> F8.

### 30. DRV5032 digital Hall-effect sensor  —  [QD v1.5+ / reusable]
- **Qty:** 2 board · **Subsystem:** Sensing · **Mfr/Part:** Adafruit/ScoutMakes 6051
- **QD verdict:** Later / TBD
- **Notes:** Magnet-presence switch. Overlaps reed (375). Likely front-module presence/keying. Confirm intent (Q4).

### 31. IR Break-Beam Sensor, 5mm LEDs  —  [QD v1.5+ / reusable]
- **Qty:** 2 pair · **Subsystem:** Sensing · **Mfr/Part:** Adafruit 2168
- **QD verdict:** Later (v1.5+)
- **Notes:** Emitter+detector beam-break (digital). Possible edge/tripwire/object-pass sense. Uses 3-pin JST-PH cable (3893).

### 32. DS3231 Precision RTC, STEMMA QT  —  [Committed: QD v1]
- **Qty:** 2 board · **Subsystem:** Sensing · **Mfr/Part:** Adafruit 5188
- **QD verdict:** Core (1); 2nd spare
- **Notes:** Real clock for timestamping significance/decay. FIXED addr 0x68 -> TWO CANNOT SHARE A BUS (collide). See F12.

### 33. Qwiic / STEMMA QT 5-Port Hub  —  [Committed: QD v1]
- **Qty:** 1 board · **Subsystem:** Sensing / Infra · **Mfr/Part:** Adafruit 5625
- **QD verdict:** Core
- **Notes:** Passive I2C fan-out (1->5). For UNIQUE-address devices. Use mux (not hub) for address-colliders (ToF, 2nd RTC).

### 34. Perma-Proto half-sized breadboard PCB  —  [Committed: QD v1]
- **Qty:** 6 board · **Subsystem:** Wiring / Proto · **Mfr/Part:** Adafruit 1609
- **QD verdict:** Core
- **Notes:** Solderable proto substrate for the internal electronics stack (level shifter, ADC, hub mounting).

### 35. 6mm 3MP Wide-Angle Lens, CS-mount  —  [Committed: QD v1]
- **Qty:** 1 unit · **Subsystem:** Sensing / Camera · **Mfr/Part:** Adafruit 4563
- **QD verdict:** Core
- **Notes:** Wide lens for the Global Shutter Camera (CS mount). This is the 'wide-angle' from records.

### 36. Flex cable for Pi Camera, 24in / 610mm  —  [Committed: QD v1]
- **Qty:** 1 cable · **Subsystem:** Sensing / Camera · **Mfr/Part:** Adafruit 1731
- **QD verdict:** Core
- **Notes:** Confirms the 24in camera flex from records. Fragile. Routes Pi CSI -> ridge camera.

### 37. STEMMA QT JST-SH 4-pin cables, assorted  —  [Committed: QD v1]
- **Qty:** 20 cable · **Subsystem:** Wiring · **Mfr/Part:** Adafruit 5385/5384/4401/4210
- **QD verdict:** Core
- **Notes:** This order: 400mm x4, 300mm x4, 200mm x4, 100mm x8. I2C chaining stock.

### 38. STEMMA JST-PH 2mm 3-pin to male header cable  —  [QD v1.5+ / reusable]
- **Qty:** 2 cable · **Subsystem:** Wiring · **Mfr/Part:** Adafruit 3893
- **QD verdict:** Later
- **Notes:** 3-pin (not 4) - pairs with the IR break-beam sensors.

### 39. PCB Coaster, gold Adafruit logo  —  [-]
- **Qty:** 1 unit · **Subsystem:** Swag / non-build · **Mfr/Part:** Adafruit 5719
- **QD verdict:** N/A (swag)
- **Notes:** Free promo item. Not a build part - logged for completeness.

### 40. microSD card, 32GB (Pi OS)  —  [Committed: QD v1]
- **Qty:** 1 card · **Subsystem:** Compute / Storage · **Mfr/Part:** CanaKit (SanDisk)
- **QD verdict:** Core
- **Notes:** Holds the OS. Abrupt power-off risks ext4 corruption -> graceful LVC shutdown and/or read-only rootfs (F14).

### 41. CanaKit 2.5A microUSB power supply  —  [Bench equipment]
- **Qty:** 1 unit · **Subsystem:** Power / Support · **Mfr/Part:** CanaKit
- **QD verdict:** Support (bench only)
- **Notes:** BENCH ONLY - powers Pi at desk. Rover Pi runs off D24V22F5 buck. Not a rover part.

### 42. CanaKit black case (Pi 3)  —  [Bench equipment]
- **Qty:** 1 case · **Subsystem:** Compute / Support · **Mfr/Part:** CanaKit
- **QD verdict:** Support (not in rover)
- **Notes:** Pi uses the printed QD chassis instead. Case = bench/spare. (Kit heatsinks DO carry to rover - see F15.)

### 43. Rii mini X1 wireless keyboard/touchpad  —  [Bench equipment]
- **Qty:** 1 unit · **Subsystem:** Support · **Mfr/Part:** Rii
- **QD verdict:** Support (bench tool)
- **Notes:** Bench input for Pi setup. Not a CanaKit item; not a rover part.

### 44. 37-in-1 Sensor Kit  —  [Free - library]
- **Qty:** 1 kit · **Subsystem:** Sensing / Proto · **Mfr/Part:** RobotLinking 37-in-1
- **QD verdict:** Bench/proto (not rover BOM, except picks)
- **Notes:** Breadboard learning kit. MOSTLY REDUNDANT w/ owned gear (Hall->DRV5032; temp/RH->BME688; sound->SPH0645; reed->375; tilt/shock->BNO085). ROVER PICKS: IR reflectance (down=cliff/edge), shock/tilt (impact/tip) -> reflex layer via KB2040 (F16). Buzzer = only audio OUTPUT in inventory. [Library stock for future builds.]

### 45. HC-SR501 PIR motion sensor  —  [Committed: QD v1]
- **Qty:** 5 unit · **Subsystem:** Sensing · **Mfr/Part:** HC-SR501 (BISS0001)
- **QD verdict:** Core candidate (at-rest only)
- **Notes:** Pyroelectric presence of moving warm bodies = strongest 'otherness'/significance input. INVALID WHILE MOVING (self-motion->false triggers): use at-rest only, gate on zero-velocity (F17). Out=3.3V (Pi-safe, no shifter); VCC 5V; 30-60s warmup. Set delay pot min, jumper H. LWIR opaque to shell -> domes must be exposed (F17).

### 46. DHT11 / DHT22(AM2302) temp-humidity modules  —  [Free - library]
- **Qty:** 7 unit · **Subsystem:** Sensing · **Mfr/Part:** DHT11 x5 + DHT22/AM2302 x2
- **QD verdict:** Bench/proto (redundant)
- **Notes:** REDUNDANT w/ BME688 (better accuracy/speed + adds pressure/gas). Single-wire bit-bang = worst-case on a Pi (non-RT scheduler -> CRC fails). If ever used: KB2040 only, never Pi. DHT11 count ~5 (confirm). [Library stock for future builds.]

### 47. Dupont jumper wires, assorted (F-F / F-M / M-M)  —  [Free - library]
- **Qty:** 3 bundle · **Subsystem:** Wiring · **Mfr/Part:** Generic
- **QD verdict:** Bench/proto consumable
- **Notes:** For breadboard bring-up (validate sensors loose before solder/JST). Not rover BOM. [Library stock for future builds.] [+2 Elegoo kits (F-F/F-M/M-M) = qty 3; now includes M-M. F-M = Pi/breakout pins to breadboard, workhorse for sensor-bus bring-up.]

### 48. Solar panel, mini poly ~68x37mm  —  [Free - library]
- **Qty:** 10 unit · **Subsystem:** Power · **Mfr/Part:** RY9-38 (rating unmarked)
- **QD verdict:** Library (not v1)
- **Notes:** TOY BOX. Form factor confirmed (68x37mm). RATING NOT PRINTED -> measure Voc/Isc in sun (typical ~5-6V/30-60mA for size, verify). Condition: intact, solar ages well. QD: NOT v1 power (3S needs 12.6V + charge mgmt; naive solar->LiPo is unsafe); light-sensor role redundant w/ photoresistors. Good for standalone solar project. Provenance/rating: ask Darrell. [Library stock.]

### 49. DIY Solar Power Box (self-built)  —  [None]
- **Qty:** 1 unit · **Subsystem:** Power / Equipment · **Mfr/Part:** Self-built; Stack-On case
- **QD verdict:** Equipment (not QD)
- **Notes:** Self-built portable solar power station. Components: Renogy PWM charge controller; 2x ExpertPower SLA ~12V 9Ah (EXP1290-class, AGM); fused distribution block; watt-meter/power analyzer; 3 panel rockers; sunvisor panels. CONDITION: electronics fine; SLA PAIR is aging risk -> sulfation if stored unmaintained; test rested V (>12.6 healthy) + load before trust; likely REPLACE. Vent before charging SLA in sealed steel box. QD: NOT a part (12V lead-acid vs 3S LiPo; controller is PbA-profiled). Usable as 12V bench/field supply; components harvestable.

### 50. Relay module, 4-channel (opto-isolated)  —  [Free - library]
- **Qty:** 1 board (4 relays) · **Subsystem:** Power / Switching · **Mfr/Part:** Songle SRD-05VDC-SL-C x4
- **QD verdict:** Library (not QD)
- **Notes:** 5V coils; 10A 250VAC / 10A 30VDC SPDT; opto-isolated ACTIVE-LOW inputs; JD-VCC jumper isolates coil from logic power. CONDITION: fine (no electrolytics; relays/optos age well). QD: NO - wrong for DC mobile robot (coil ~80mA standing each = drain vs F13; can't PWM; QD switching is PWM->MOSFET or solid-state via TB6612 STBY). GOOD FOR: mains/AC switching, home automation (10A 250VAC + isolation). [Library stock.]

### 51. Photoresistor, CdS (GL5528 likely)  —  [QD candidate (v1.5+)]
- **Qty:** 20 pcs · **Subsystem:** Sensing · **Mfr/Part:** Gikfun EK1412 (GL55xx)
- **QD verdict:** Candidate v1.5+ (light sense)
- **Notes:** ~10-20k light / ~1M dark; analog via ADS1115. ON-THESIS as light-significance input (shadow/dusk/lights-on). NOTE: camera already gives luminance free; CdS slow/drifty; VEML7700/TSL2591 = precise route. Not v1 (F8 creep). CONDITION: fine. CdS=cadmium (RoHS; fine for hobby).

### 52. White LED emitter, round  —  [Free - library]
- **Qty:** 100 pcs · **Subsystem:** Output / Light · **Mfr/Part:** Yootop (X001TL48LH)
- **QD verdict:** Library (poss. 1-2 cam fill-light)
- **Notes:** White, Vf ~3-3.4V (blue die + yellow phosphor). NOT addressable (!= WS2812 debug band). Exact bead wattage/package TENTATIVE (look small/low-power). QD: maybe 1-2 as low-light camera illumination; rest library. CONDITION: fine.

### 53. Reed switch, glass axial (SPST-NO)  —  [Free - library]
- **Qty:** 20 pcs (approx) · **Subsystem:** Sensing · **Mfr/Part:** Generic glass reed (E383)
- **QD verdict:** Library / spare (dock-detect v1.5?)
- **Notes:** CONFIRMED reed switches (close-up: overlapping blades + contact gap in glass envelope). ~20 pcs. Passive SPST-NO, closes near magnet, ZERO standing power, reads on GPIO+pullup (no ADC/I2C). QD: NOT v1 (core=cam+ToF+IMU). Best potential job = zero-power charging-dock presence detect (v1.5+); for moving-chassis magnetics DRV5032 Hall wins (solid-state, vibration-immune). See Q4. CONDITION: fine but FRAGILE glass - bend leads away from seal; store in clamshell.

### 54. High-power COB LED, white ~50W  —  [Free - library]
- **Qty:** 1 pcs · **Subsystem:** Output / Light · **Mfr/Part:** Generic COB (~40mm)
- **QD verdict:** Library (NOT QD)
- **Notes:** ~40mm sq, ~100-die array, Vf ~30-34V, ~50W class (30-100W; no wattage stamp = TENTATIVE). Needs CC driver + real heatsink. QD: NO - 30V+ off 3S needs boost; flattens 2200mAh in minutes; cooks sealed body. GOOD FOR: floodlight/work light. CONDITION: fine.

### 55. Trimmer pot, assorted 100R-100k  —  [Bench/library]
- **Qty:** 8 pcs (approx) · **Subsystem:** Passives / Bench · **Mfr/Part:** 3362/3386-style (B taper)
- **QD verdict:** Bench/library (not QD)
- **Notes:** Blue single-turn trimpots. Codes 101/102/103/104 = 100R/1k/10k/100k; B=linear. QD: NO native use (digital/I2C, nothing to trim). Bench/breadboard analog stock. CONDITION: fine (wipers look unused; contact cleaner if scratchy).

### 56. ESP32 dev board w/ OLED (WiFi Kit 32)  —  [Bench/library]
- **Qty:** 1 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** Heltec HTIT-WB32
- **QD verdict:** Bring-up tool (off-board telemetry)
- **Notes:** ESP32 dual-core (WiFi+BT); 0.96" SSD1306 OLED (I2C); CP2102 USB-UART; 8MB flash (W25Q64); onboard 1S LiPo charge + JST. QD: NOT compute (Pi+KB2040 cover brain+reflex; WiFi dup of Pi). Onboard OLED OFF-THESIS (screen reads as 'gadget'; LED band = creature-like affect, no literal readout). BEST USE: OFF-board wireless telemetry dashboard for bring-up (Pi -> WiFi/ESP-NOW -> OLED: live batt V / mode / significance, untethered). Ties Gate B / first power-on. CONDITION: fine.

### 57. ESP32 dev board, bare (WROOM-32)  —  [Bench/library]
- **Qty:** 5 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** ESP32 DevKit (generic)
- **QD verdict:** Library / opt. bring-up remote
- **Notes:** ESP32-WROOM-32; WiFi+BT+BLE; micro-USB; CP2102 UART; AMS1117 3V3. NO OLED / NO LiPo charger (cf Heltec). QD: NOT compute (Pi+KB2040 settled; WiFi dup of Pi). No screen = not a dashboard. OPTIONAL: ESP-NOW manual-drive/override remote for bring-up (pairs w/ Heltec readout = untethered cockpit). NOT a safety e-stop - reflex stays onboard KB2040. Else general dev/library. CONDITION: fine. [+3 ESP32 DevKit V1 (WROOM-32, back-silk confirmed) added same verdict = qty 5 total.]

### 58. ESP8266 dev board (NodeMCU + D1 Mini)  —  [Bench/library]
- **Qty:** 5 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** HiLetgo NodeMCU x4 + Wemos D1 Mini x1
- **QD verdict:** Library / dev spare
- **Notes:** ESP8266MOD (ESP-12E); WiFi-ONLY (no BT/BLE); CP2102 UART; micro-USB; Vin 5V rec / 10V max; single-core, fewer GPIO than ESP32. QD: NOT compute (Pi+KB2040 settled; weaker than ESP32s already ruled out; WiFi dup of Pi). Speaks ESP-NOW so *could* be bring-up node/remote, but ESP32 is better - deeper-bench spare. MCU CATEGORY CLOSED/over-stocked: 3x ESP32 + 4x ESP8266 = 7 WiFi MCUs, none on QD; any further WiFi MCU = same verdict. CONDITION: fine (straighten bent header pins). [+1 Wemos/LOLIN D1 Mini (ESP8266, compact FF w/ LOLIN shield ecosystem) = qty 5. Same verdict.]

### 59. Arduino Uno/Nano (ATmega328P)  —  [Bench/library]
- **Qty:** 7 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** 1 genuine Uno (Italy) + IEIK/Elegoo Uno + 3x Elegoo Nano V3 + 1 Elegoo Uno R3
- **QD verdict:** Library / bench / learning
- **Notes:** ATmega328P; 8-bit AVR; 16MHz; 5V logic; 32KB flash / 2KB RAM; 14 DIO / 6 AIN; USB-B. QD: NOT compute (Pi+KB2040 settled). 8-bit/5V = weaker + needs level-shift to 3.3V Pi, AND this is the Arduino/AVR toolchain the project deliberately moved OFF of -> KB2040/CircuitPython was the right call. Good = 5V bench workhorse / learning. Genuine Italy unit = real ATmega16U2 USB + keepsake; IEIK/Elegoo = CH340 clones (equal workhorses). MCU now overstocked across ALL families (AVR + ESP8266 + ESP32); QD uses 2 boards total. CONDITION: fine; electrolytics only age-sensitive part, no bulge/leak. [+3x Elegoo Nano V3.0 (same ATmega328P, small format) = qty 6 total. Small footprint does NOT earn a chassis seat: still 8-bit/5V, needs level-shift to 3.3V Pi, KB2040 owns reflex on better toolchain.] [+1 more Elegoo Uno R3 = qty 7. Same verdict: AVR bucket, not QD.]

### 60. Raspberry Pi Pico (RP2040, non-W)  —  [QD bench tool]
- **Qty:** 1 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** Raspberry Pi Pico (c)2020
- **QD verdict:** QD bench tool - reflex dev twin
- **Notes:** RP2040 (SAME silicon as KB2040); NON-wireless (no Pico-W shield = correct, no radio on a reflex co-pro). Micro-USB, BOOTSEL, 26 GPIO broken out on 0.1in grid, 3x ADC. QD ROLE (real, not library): bench TWIN for reflex-layer dev - same chip + same CircuitPython toolchain as KB2040, but roomy/easy to probe. Develop+debug reflex here -> deploy validated code to KB2040 (flight HW). Does NOT replace KB2040 in chassis (KB2040 won on size/USB-C/STEMMA-QT; Pico too big for pill). CONDITION: fine.

### 61. USB-serial adapter (FTDI FT232RL)  —  [QD bench tool]
- **Qty:** 1 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** FT232RL breakout (HW-417)
- **QD verdict:** QD bench tool - Pi serial console
- **Notes:** FT232RL USB-to-UART bridge (NOT an MCU). 6-pin FTDI header DTR/RXD/TXD/VCC/CTS/GND; SELECTABLE 3.3V/5V jumper; mini-USB. QD ROLE (real, not library): serial CONSOLE into Pi for headless bring-up/debug (Pi UART GPIO14 TX / GPIO15 RX) = boot msgs, kernel logs, login prompt, ZERO network dependency. Best low-level debug for a headless robot. ** CRITICAL: jumper to 3.3V (Pi UART is 3.3V, NOT 5V-tolerant; 5V damages GPIO). ** Aside: some FT232RL boards = clone chips; fine on Linux/Pi, may no-show on Windows. CONDITION: fine.

### 62. TP4056 1S Li charger (protected)  —  [Free - library]
- **Qty:** 10 pcs · **Subsystem:** Power / Switching · **Mfr/Part:** TP4056+DW01A+8205A (03962A)
- **QD verdict:** Library (power shelf) - NOT QD power
- **Notes:** 1S (single-cell 3.7/4.2V) Li-ion/LiPo charger, PROTECTED (DW01A over-dis/over-cur + 8205A dual MOSFET). Micro-USB in; B+/B- cell, OUT+/OUT- protected load; ~1A default (Rprog-set); 4.2V CC/CV; red/blue LEDs. QD: NOT main power - pack is 3S (11.1V), needs iMAX B6 BALANCE charger (1S charger CAN'T do 3S; wrong class). Nearest hook=1S backup cell for F14 hold-up, BUT TP4056=charger not power-path/UPS, AND read-only rootfs is simpler F14 fix -> hook doesn't land. Joins power-shelf library (solar panels, relay bd). CONDITION: fine (no electrolytics).

### 63. Arduino MKR WiFi 1010 + Nano 33 IoT  —  [Bench/library (capable)]
- **Qty:** 2 pcs (1 each) · **Subsystem:** Compute / Tools · **Mfr/Part:** Genuine Arduino (SAMD21 + u-blox NINA-W102)
- **QD verdict:** Bench/library - capable 3.3V spares
- **Notes:** SAMD21 Cortex-M0+ 32-bit @48MHz, 3.3V native; WiFi+BT (NINA-W102=ESP32 inside); crypto chip. MKR=LiPo JST+charger; Nano 33 IoT=onboard LSM6DS3 6-axis IMU. NOTE: run CircuitPython (same toolchain as KB2040) - NOT the AVR/C++ env that fought the build; do NOT lump w/ Unos. QD: NOT compute (Pi=vision brain, KB2040=reflex & faster dual-core 133MHz; WiFi dups Pi). Mild angle: self-contained 3.3V wireless nodes (opt ESP-NOW remote/sensor node); Nano33 IMU neat but BNO085 better+committed. VALUE: genuine Italian (~$30-40 ea) = good spares, keep separate from clones. CONDITION: fine.

### 64. GPS receiver (GT-U7) + patch antenna  —  [Free - library]
- **Qty:** 1 set · **Subsystem:** Sensing · **Mfr/Part:** GoouuTech GT-U7 + SIM39EA ant
- **QD verdict:** Library (NOT QD) - GPS poor fit
- **Notes:** NEO-6M-class GNSS rx; NMEA over UART (~9600 default); micro-USB for PC test; 5-pin hdr (VCC/RX/TX/GND/PPS); SIM39EA ceramic patch antenna via u.FL. QD: POOR FIT - (1) needs sky view, won't fix indoors where rover lives; (2) SCALE: GPS ~meters vs QD=180mm robot in a ~few-m room -> can't localize within a room even outdoors. QD localization = camera+ToF+IMU+encoders. Precise-time redundant w/ DS3231 RTC (& needs a fix). Caveat: outdoor QD variant would change this. GOOD FOR: outdoor tracker/datalogger/GPS clock. CONDITION: fine; u.FL delicate.

### 65. Adafruit Circuit Playground Express  —  [QD bench tool]
- **Qty:** 2 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** Adafruit CPX (ATSAMD21)
- **QD verdict:** QD bench tool - LED-band/behavior dev
- **Notes:** SAMD21 @48MHz, 3.3V, CircuitPython; Adafruit ecosystem (same as KB2040/sensors). Onboard: 10x NeoPixel (WS2812!), LIS3DH accel, light/temp/sound sensors, IR tx/rx, 2 btn, slide sw, speaker, touch. 'Developer Edition'=dev variant, same fn. QD: NOT compute/component (Pi+KB2040 settled; fixed round bd doesn't fit pill/arch). REAL ROLE: prototype the LED DEBUG-BAND at desk - 10 onboard NeoPixels = same WS2812 + same `neopixel` lib as QD band; develop/tune idle/attention/engaged/fault/reflex states+animations, then port. Also rough behavior sketchpad (onboard accel/mic/light to rehearse significance->affect loop). 3rd bench-kit tool (w/ Pico reflex-dev, FTDI Pi-console). CONDITION: fine.

### 66. Env sensor BME280/BMP280  —  [Free - library]
- **Qty:** 1 pcs · **Subsystem:** Sensing · **Mfr/Part:** GY-BME/BMP280 (GYBMEP, I2C)
- **QD verdict:** Library (NOT QD) - redundant
- **Notes:** I2C temp/pressure(/humidity). QD: REDUNDANT - committed BME688 is a STRICT SUPERSET (temp/press/humidity + gas/VOC). Adds nothing over a better part already owned (cf DHT11/22). CAVEAT: purple GYBMEP boards often actually BMP280 (NO humidity) despite 'BME' silk - verify by chip ID (0x60=BME280, 0x58=BMP280). CONDITION: fine.

### 67. 0.96in OLED display (SSD1306)  —  [Bench/library]
- **Qty:** 1 pcs · **Subsystem:** Output / Light · **Mfr/Part:** SSD1306 0.96in I2C (0x78/0x7A)
- **QD verdict:** Library (NOT QD) - off-thesis screen
- **Notes:** I2C 128x64 OLED, addr 0x78/0x7A selectable. QD: OFF-THESIS onboard (same call as Heltec screen) - text screen reads as 'gadget/interface'; QD signals state via LED band as ambient affect, not a readout. Do NOT put on chassis. Off-board = fine display for bench readout/dashboard, but Heltec already covers that. CONDITION: fine (handle gold ribbon/flex gently).

### 68. 16x2 character LCD (HD44780)  —  [Free - library]
- **Qty:** 1 pcs · **Subsystem:** Output / Light · **Mfr/Part:** QAPASS 1602A (bare parallel)
- **QD verdict:** Library (NOT QD) - off-thesis screen
- **Notes:** 16x2 char LCD, HD44780-compatible, blue backlight, BARE 16-pin PARALLEL (no I2C backpack). QD: OFF-THESIS onboard (same call as OLED/Heltec - char readout = max 'gadget'; QD speaks via LED band). LESS useful than OLED even on bench: wants 6+ GPIO (or add PCF8574 backpack), 5V, needs contrast trimpot on V0. I2C OLED is better bench display. CONNECTION: the blue trimmers logged earlier = the V0 contrast pot for this. CONDITION: fine.

### 69. Data logging shield (SD + DS1307 RTC)  —  [Free - library]
- **Qty:** 1 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** Deek-Robot Data Logging Shield V1.0 (HW-169)
- **QD verdict:** Library (NOT QD) - redundant + wrong FF
- **Notes:** Arduino UNO SHIELD: full-size SD slot (SPI, 74HC125 level-shift) + DS1307 RTC (I2C 0x68, CR1220 backup) + proto area. QD: NOT QD - (1) UNO shield FF; QD=Pi+KB2040, nothing to stack on; (2) RTC redundant+INFERIOR: committed DS3231 is TCXO +/-2ppm vs DS1307 bare-xtal (drifts min/month), same addr 0x68 collide (F12); (3) SD redundant: Pi has own boot/storage SD. ** F14 TRAP: this SD slot does NOT fix F14 (Pi's-own-SD corruption) - different card/bus, unrelated; fix is read-only rootfs / graceful shutdown. ** GOOD FOR: Arduino datalogger. CONDITION: fine (needs CR1220 if RTC used).

### 70. Seeeduino XIAO (SAMD21)  —  [Bench/library (capable)]
- **Qty:** 3 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** Seeed Studio XIAO SAMD21
- **QD verdict:** Bench/library - capable 3.3V spare
- **Notes:** SAMD21 Cortex-M0+ @48MHz, 3.3V, USB-C, CircuitPython; TINY (~20x17.5mm) castellated; genuine Seeed. Capable-spares class (w/ MKR/Nano 33); NOT AVR bucket. QD: NOT compute (Pi+KB2040 settled; KB2040=RP2040 dual-core 133MHz, faster + STEMMA QT). NOT a reflex-dev twin like Pico - DIFFERENT chip (SAMD21 vs KB2040's RP2040), code not drop-in -> spare, not bench tool. Tiny size doesn't unlock QD role (no 3rd-MCU slot; can't displace faster KB2040). Deepens overstocked MCU shelf. CONDITION: fine.

### 71. Tiny RTC I2C module (DS1307 + EEPROM)  —  [Free - library]
- **Qty:** 5 pcs · **Subsystem:** Sensing · **Mfr/Part:** DS1307 + AT24C32 (Tiny RTC)
- **QD verdict:** Library (NOT QD) - redundant/inferior RTC
- **Notes:** DS1307 RTC + 32.768kHz xtal + AT24C32 4KB I2C EEPROM (0x50) + LIR2032 coin holder. QD: NOT QD - same as logging-shield RTC: DS1307 redundant+INFERIOR to committed DS3231 (TCXO +/-2ppm vs bare-xtal drift min/month), same addr 0x68 collide (F12). EEPROM=minor library bonus. GOTCHA: board has LIR2032 *rechargeable* charge circuit - do NOT fit a plain CR2032 (will try to charge non-rechargeable cell); use LIR2032 or disable charge R. 3rd inferior-RTC sighting (logging shield, GPS-time, now 5x); timekeeping settled on DS3231. CONDITION: fine (holders empty).

### 72. nRF24L01+ 2.4GHz transceiver  —  [Free - library]
- **Qty:** 2 pcs · **Subsystem:** Compute / Tools · **Mfr/Part:** Nordic nRF24L01+ module
- **QD verdict:** Library (NOT QD) - radio redundant w/ Pi WiFi
- **Notes:** 2.4GHz GFSK transceiver, SPI (CE/CSN/SCK/MOSI/MISO/IRQ), 3.3V VCC (NOT 5V; logic inputs 5V-tol), ~1-2Mbps, PCB antenna. QD: NOT QD - wireless link redundant w/ Pi built-in WiFi/BT (cf ESP radios). For optional bring-up remote, ESP-NOW on earmarked ESP32s is easier (built-in vs host-MCU+stack at BOTH ends). GOTCHA: classic TX brownout - add 10uF cap across VCC/GND (left module looks already reworked w/ cap). GOOD FOR: low-power custom RF link / wireless sensor node / RC. CONDITION: fine (left hand-soldered, cosmetic).

### 73. ESP32-CAM + OV2640 camera  —  [Free - library]
- **Qty:** 2 sets · **Subsystem:** Sensing · **Mfr/Part:** AI-Thinker ESP32-CAM (ESP32-S + OV2640)
- **QD verdict:** Library (NOT QD) - inferior cam + redundant compute
- **Notes:** AI-Thinker ESP32-CAM: ESP32-S (WiFi+BT) + OV2640 2MP cam + microSD + LED flash + 4MB PSRAM; NO onboard USB (flash via ext USB-serial -> the FTDI). 2 boards + 2 OV2640. QD: NOT QD - (1) NOT compute: Pi=vision brain; ESP32 can't run attention/significance vision; (2) NOT camera: QD uses GLOBAL-SHUTTER (#5702) deliberately - moving robot needs it (no rolling-shutter motion jello on the very motion she attends to); OV2640=rolling-shutter, lower-res, parallel DVP (incompatible w/ Pi CSI); (3) NOT a vision-dev twin (too weak, wrong sensor/toolchain - unlike CPX/NeoPixel). USE: self-contained cheap WiFi cam (webcam/wildlife). Mild QD-adjacent: EXTERNAL observation cam watching QD during bring-up (3rd-person debug), not part of robot. CONDITION: fine.

### 74. microSD card module (SPI)  —  [Free - library]
- **Qty:** 5 modules · **Subsystem:** Storage · **Mfr/Part:** HW-125 (74VHC125 buffer + 3.3V reg)
- **QD verdict:** Library (NOT QD) - Pi has native SD; does NOT fix F14
- **Notes:** SPI microSD breakout: GND/VCC/MISO/MOSI/SCK/CS; onboard 3.3V reg + 74VHC125 buffer (5V-Arduino friendly). 5 units, look new. QD: NOT QD - (1) Pi boots/logs via its OWN native SD slot (row 44), far faster than SPI + already in design; SPI SD is for compute WITHOUT an SD slot. (2) KB2040 reflex co-pro doesn't journal to disk - logging lives on Pi. (3) TRAP: does NOT fix F14 (SD-corruption-on-abrupt-poweroff) - that's a filesystem fix (read-only rootfs / graceful shutdown), not a hw-shortage; a 2nd card = a 2nd thing to corrupt. Same trap as the data-logging shield. USE: classic standalone-MCU datalogger (pair w/ DS3231 + sensor + AVR/ESP, no PC). CONDITION: fine/new.

### 75. Micro servo 9g (SG90-class)  —  [QD v1.5 - articulation (2 + spares)]
- **Qty:** 10 servos · **Subsystem:** Actuation · **Mfr/Part:** Smraza S51 (analog, plastic gear, ~180deg positional)
- **QD verdict:** QD v1.5 CANDIDATE - camera ridge articulation (pan/tilt)
- **Notes:** SG90-class 9g analog micro servo, positional ~180deg, plastic gears, horns+screws incl. 10 units. QD: REAL HIT (not library). v1.5 articulation is locked = pan +-90-120 / tilt sky-biased, ridge moves as unit, SERVOS IN BODY via linkage/pushrod -> 2 servos. Use 2 + 8 spare/proto. CAVEATS for FLIGHT build (truth over comfort): (1) cheap analog 9g jitter/hunt/buzz - works against QD's deliberate legible-motion premise; consider DIGITAL METAL-GEAR micro servo for flight (smooth/quiet/repeatable). (2) plastic gears back-drive/strip on shock-load (bump) -> MG90S-class more robust. (3) servo current spikes (stall ~0.5-0.7A ea) + noise -> own buck/rail w/ decoupling, NOT sensor rail (ties F13). (4) pan +-120 (240deg) exceeds ~180deg throw -> gear via linkage ratio or settle +-90. These = ideal PROTOTYPING servos; flight servo TBD (see F18). Verify positional (not continuous) - horns/label indicate positional. CONDITION: new.

### 76. 18650 battery holder (1S)  —  [Free - library (power shelf)]
- **Qty:** 10 holders · **Subsystem:** Power · **Mfr/Part:** Single-cell 18650, 3.7V, flying leads
- **QD verdict:** Library (NOT QD) - power locked on 3S LiPo
- **Notes:** Single-18650 holder, 3.7V (1S), spring contact + red/black leads. 10 units, new. QD: NOT QD - power is LOCKED on 3S LiPo (Zeee 2200mAh) + iMAX charger; these are 1S holders (wrong series config) and re-opening battery chemistry now = regression. USE: general power-shelf stock (battery banks, any 3.7V project; 3x in series would make ~11.1V but QD already has its pack). Joins the self-sorting power library (w/ solar gear). CONDITION: new.

### 77. Magnetic reed switch set (housed)  —  [Free - library]
- **Qty:** 5 sets · **Subsystem:** Sensing · **Mfr/Part:** Door/window-alarm type, ASIN B07YVG637M
- **QD verdict:** Library (NOT QD) - Q4 resolved; bulky door-alarm type
- **Notes:** HOUSED reed switch + magnet block sets (screw-terminal door/window alarm style) - NOT the bare glass reeds logged earlier. 5 sets, new. QD: NOT QD - ties Q4 (RESOLVED): DRV5032 Hall = on-chassis magnetic sensor of record (solid-state, vibration-immune); reeds = library/spare for possible v1.5 zero-power dock-detect. These housed sets are EVEN LESS QD-suited than bare reeds: bulky, built to screw on a doorframe, won't embed in 72mm pill. If dock-detect ever built, bare glass reeds are the better candidate. USE: door/window sensing (as sold). CONDITION: new.

### 78. Heat-set threaded inserts (M2/M3/M4/M5)  —  [Committed: QD v1]
- **Qty:** 1 kit (270pc) · **Subsystem:** Chassis / Fasteners · **Mfr/Part:** ruthex 270pc (brass) ASIN X003E0A4VK7
- **QD verdict:** Core
- **Notes:** ruthex brass heat-set inserts: M2 70 / M3 100 / M4 50 / M5 50. THE method for threads in printed parts (melt insert into PETG/ASA -> metal threads for screws). M3x100 = workhorse for QD modular shells. NOTE (F7): kit has M2/M3/M4/M5 but NOT M2.5 - Pi is M2.5, so this does NOT close the two-fastener-systems flag; Pi still uses Geekworm M2.5 kit (row 22). Matches 'ruthex inserts' from procurement - now logged. CONDITION: new.

### 79. M3 socket-head screw kit (304 SS)  —  [Committed: QD v1]
- **Qty:** 1 kit (600pc) · **Subsystem:** Chassis / Fasteners · **Mfr/Part:** VGBUY 600pc
- **QD verdict:** Core
- **Notes:** M3 socket-head cap screws, 304 stainless: M3x6/8/12/20/25/30 + 150 M3 nuts + 300 lock/flat washers. M3 = QD chassis standard. SHORT lengths (6-12mm) join shell modules into heat-set inserts = the QD-relevant part. 20-30mm + nuts = overflow (heat-set insert IS the nut, nuts rarely needed). Matches 'M3 screws' from procurement - now logged. CONDITION: new.

### 80. M4 brass hardware (inserts or standoffs?)  —  [Free - library]
- **Qty:** 180 pcs · **Subsystem:** Chassis / Fasteners · **Mfr/Part:** A010-180, 'Brass M4 180pcs' ASIN X0022W2SAF
- **QD verdict:** Library (NOT QD) - M4 off the M3 standard
- **Notes:** TENTATIVE ID: closed box labeled 'Brass M4 180pcs' - could be M4 brass heat-set INSERTS (short knurled barrels) or M4 STANDOFFS (longer hex pillars). Opening settles it. Either way LIBRARY: M4 is off QD's M3 chassis standard (+ M2.5 Pi); nothing in QD design calls for M4. General fastener stock. CONDITION: new.

### 81. BJT transistor assortment, 675pc  —  [Free - library]
- **Qty:** 1 kit (675pc) · **Subsystem:** Discrete semis · **Mfr/Part:** Hilitchi 675pc (15 values x45) ASIN X001DQ71SZ
- **QD verdict:** Library - general small-signal stock
- **Notes:** Through-hole BJT assortment: ~15 values incl 2N2222/2N3904/2N3906/C1815/A1015/S8050/S8550/S9012-S9015 etc, 45 ea. QD: not a SPECIFIED part - switching lives in integrated parts (TB6612 motors, BSS138 level-shift). But ideal general bench stock for occasional small-signal switching. Library. CONDITION: new.

### 82. Power MOSFET kit, 50pc (10 values)  —  [Free - library]
- **Qty:** 1 kit (50pc) · **Subsystem:** Discrete semis · **Mfr/Part:** BOJACK (IRF/IRFP series, TO-220) ASIN X001...
- **QD verdict:** Library - power switching; mostly non-logic-level
- **Notes:** 10 values x5: IRF540N/640N/740/840/3205/9540N/Z44N/IRFP260/460 class TO-220 POWER MOSFETs. QD: not needed - motors handled by TB6612; most of these are NON-logic-level (want ~10V gate, won't switch cleanly from 3.3/5V w/o gate driver). General power-switching / DIY H-bridge stock. Library. CONDITION: new.

### 83. Resistor kit (through-hole assortment)  —  [Free - library (bench)]
- **Qty:** 1 kit · **Subsystem:** Passives · **Mfr/Part:** Elegoo
- **QD verdict:** Library - USEFUL QD bench stock
- **Notes:** TH resistor assortment (multi-value). Library but genuinely used during QD bring-up: I2C pull-ups, LED current-limit (band proto), reflex-input pull-downs. CONDITION: fine.

### 84. Ceramic capacitor kit, 600pc (15 val)  —  [Free - library (bench)]
- **Qty:** 1 kit (600pc) · **Subsystem:** Passives · **Mfr/Part:** BOJACK 10pF-100nF
- **QD verdict:** Library - USEFUL QD bench (decoupling)
- **Notes:** TH ceramic disc caps 10pF-100nF, 15 values x40. Library but = QD's DECOUPLING/BYPASS stock (the '100nF across supply pins' for servos/nRF brownout/sensor rails). CAVEAT: tops out 100nF - BULK decoupling (10uF+ near buck/servos) needs electrolytic/tantalum sourced separately. CONDITION: fine.

### 85. DIP IC assortment (analog/audio jellybean)  —  [Free - library]
- **Qty:** 1 kit · **Subsystem:** Discrete/IC · **Mfr/Part:** LM358/324/339/393,NE555,ULN2003/2803,LM386,TDA,UC384x,PT2399,JRC4558 +DIP sockets
- **QD verdict:** Library (NOT QD) - different domain
- **Notes:** TH DIP assortment: op-amps (LM358/324/339/393,NE5532,JRC4558), 555 timer, Darlington arrays (ULN2003/2803), audio amps (LM386,TDA2030/2822), SMPS PWM (UC3842/3843), opto (PC817), ICL7660, PT2399 echo; + DIP sockets 4-18P. QD: NOT QD - analog/audio domain; QD analog sensing = ADS1115 I2C ADC, motors = TB6612; no discrete op-amps/timers/Darlingtons in design. Good library to own. CONDITION: fine.

### 86. Potentiometer kit, 60pc (B5K-B100K)  —  [Free - library]
- **Qty:** 60 pcs · **Subsystem:** Passives / Controls · **Mfr/Part:** SWPEET, panel pots w/ knobs/nuts/washers ASIN X002CTQP4N
- **QD verdict:** Library (NOT QD) - off-thesis (no knobs)
- **Notes:** Linear panel pots B5K/10K/20K/50K/100K + knobs/nuts/washers. QD: NOT QD - QD is autonomous, has NO human knobs (expresses via LED band) - same reason as trimmer pots (row 59). Mild bench use: hand-tunable analog test input into an ADC. Distinct from row 59 (those=tiny trimmers; these=full panel pots). CONDITION: new.

### 87. 5mm LED assortment (assorted colors)  —  [Free - library (bench)]
- **Qty:** 1 kit · **Subsystem:** Indicators · **Mfr/Part:** DiCUNO
- **QD verdict:** Library - bench indicators (NOT the band)
- **Notes:** 5mm TH LEDs, assorted colors. QD: does NOT displace QD's debug band = WS2812 addressable RGB (data-driven). These=dumb single-color TH LEDs for breadboard status blinks during bring-up. Distinct from row 56 (white-only emitters). Library/bench. CONDITION: fine.

### 88. Electrolytic capacitor assortment (2 kits)  —  [Free - library (bench)]
- **Qty:** 2 kits · **Subsystem:** Passives · **Mfr/Part:** RexQualis 696pc (0.1-2200uF) + CTR 500pc (0.1-1000uF)
- **QD verdict:** Library - USEFUL QD bench (BULK decoupling)
- **Notes:** Radial electrolytic assortments: RexQualis 24-val 696pc 0.1-2200uF + CTR 24-val 500pc 0.1-1000uF (10-50V). Library but = the BULK decoupling flagged last turn (ceramic kit topped at 100nF). These = the 10-1000uF cans across buck output / servo rail / motor-driver supply to absorb current spikes (ties F13, F18). Two kits overlap = deep redundant supply. CAVEAT: electrolytics AGE (dry out / lose C / leak) unlike ceramics - look fresh now; if any sit for years, verify/reform before trusting on a rail that matters. CONDITION: appears new.

### 89. Inductor kit, 200pc (20 value, 1W axial)  —  [Free - library]
- **Qty:** 1 kit (200pc) · **Subsystem:** Passives · **Mfr/Part:** BOJACK
- **QD verdict:** Library (NOT QD) - buck modules self-contained
- **Notes:** TH axial color-band inductors, 20 values, 1W (1uH-1mH range). QD: NOT QD - discrete inductors = for DIY SMPS / LC filters; QD power = ready-made buck modules (Pololu D24V22F5) with inductors onboard. Not building switching supplies from scratch. General library stock. CONDITION: fine.

### 90. Digital multimeter (basic)  —  [QD bench tool]
- **Qty:** 1 meter · **Subsystem:** Bench tool · **Mfr/Part:** GE2524 w/ probes
- **QD verdict:** QD BENCH TOOL - essential bring-up
- **Notes:** Basic pocket DMM: V/A/ohm/diode/continuity (no cap/freq). First meter in inventory. Essential QD bring-up: buck output V before connecting Pi, pack V, 3.3/5V rails, joint continuity, polarity checks. Adequate for QD's checks. CONDITION: working.

### 91. Solderless breadboards (assorted)  —  [Free - library (bench)]
- **Qty:** 8 approx · **Subsystem:** Bench tool · **Mfr/Part:** Full 830pt / half 400pt / mini / power-rail strips
- **QD verdict:** Bench library - SIGNAL/LOGIC only (not power)
- **Notes:** ~8 assorted solderless breadboards (830pt full, 400pt half, mini, power-rail strips). Proto-phase stock - distinct from row 38 Perma-Proto (those=SOLDERED). Workflow: breadboard I2C sensor bus / KB2040 / LED-band logic here, then commit working circuit to soldered Perma-Proto. CAVEAT: signal/logic ONLY - keep MOTOR/SERVO POWER off breadboards (spring-contact resistance can't carry motor amps; power path = soldered/direct from the start). Qty approx. CONDITION: fine.

### 92. DC bench power supply (adjustable, CV/CC)  —  [QD bench tool]
- **Qty:** 1 PSU · **Subsystem:** Bench tool · **Mfr/Part:** Tacklife MDC02
- **QD verdict:** QD BENCH TOOL - safe bring-up (CC limit)
- **Notes:** Adjustable single-output DC supply, CV/CC, V+A readout, fine/coarse, banana out. HIGH VALUE for QD: (1) CC current-limit = SAFE first power-on (clamps current on a fault instead of frying Pi/sensors). (2) Develop entire stack OFF the LiPo - dial 11.1V to stand in for 3S pack, or 5V/3.3V sub-rails - keeps pack fire/over-discharge out of the dev loop (de-risks F3/F14/brownout). CAVEAT: verify max current on label (~5A class); 2x motor STALL ~5-6A could hit the limit -> CC dips rail. Fine for logic/sensor/normal-run. CONDITION: working.

### 93. Oscilloscope, 2ch 100MHz 1GSa/s (DSO)  —  [QD bench tool]
- **Qty:** 1 scope · **Subsystem:** Bench tool · **Mfr/Part:** Hantek DSO5102P (+probe, test leads)
- **QD verdict:** QD BENCH TOOL - signal-integrity debug
- **Notes:** 2-ch 100MHz 1GSa/s digital storage scope. THE signal-integrity instrument - maps onto QD flags: I2C SDA/SCL rise-times + clock-stretch (F10) + addressing (F12); WS2812 LED-band 800kHz timing (F9); encoder quadrature levels + level-shift (F1); motor/servo PWM freq/duty (F18); supply rail noise + decoupling verification (F13). 100MHz/2ch well-matched to all QD signals; 2ch covers most debug (4ch rarely needed). Incl scope probe + red/blk test leads. CONDITION: working.

## Flags / Design Roadmap

### F1  (High · Mitigated (part in hand) · Drive)
- **Flag:** Encoder outputs swing to Vcc (3.5-20V); 3.3V below floor. Feeding 5V enc outputs to Pi GPIO can damage the pin.
- **Related:** Pololu 4885; Pi 3
- **Action:** DONE pending wiring: BSS138 4-ch level converter received. Enc Vcc 5V -> BSS138 -> 3.3V Pi.

### F2  (Medium · Open (partly mitigated) · Drive / Chassis)
- **Flag:** Stance/tip-over: 80mm wheel > 72mm body; caster+shim height vs axle for level deck; big pack mass CG. IMU now helps detect tip.
- **Related:** 3690, 2692, Zeee, 4754
- **Action:** Set caster shim to wheel axle height; mount pack low/centered; use IMU tilt in reflex layer.

### F3  (Medium · Mitigated (addressable) · Power)
- **Flag:** Fuse stops a short, NOT LiPo over-discharge. No runtime low-voltage cutoff in inventory yet.
- **Related:** Zeee; Pi
- **Action:** ADS1115 ADC received - read pack V via divider for runtime low-voltage cutoff.

### F4  (Medium · Open · Chassis / Control)
- **Flag:** KCD1 rocker needs ~19x13mm panel cutout; not in locked shell. Visible black switch also tension w/ no-anthropomorphism spine.
- **Related:** DaierTek KCD1
- **Action:** Decide placement (underside/rear vs intentional cue) BEFORE top shell is printed.

### F5  (Low · Open · Power)
- **Flag:** B6AC V2 needs a charge lead that mates to pack XT60; may not be in charger bundle.
- **Related:** SKYRC B6AC; XT60H
- **Action:** Confirm bundle; if absent, build XT60 charge lead from spare XT60H.

### F6  (Medium · Open (reframed) · Sensing / Wiring)
- **Flag:** Body-to-ridge bus: locked as 6-wire JST-XH. Mux-in-ridge could collapse it to 4-wire I2C. Connector: JST-XH (robust, flex) vs STEMMA QT JST-SH (tiny).
- **Related:** elechawk XH kit, 4397, 5626
- **Action:** Decide topology (mux in ridge?) then connector. Keep robust connector on the flex joint.

### F7  (Medium · Open · Compute / Chassis)
- **Flag:** Pi is M2.5; chassis is M3 (two fastener systems). Mount method + standoff height undecided — affects bottom plate, service hatch, camera-cable routing.
- **Related:** Geekworm kit; Pi 3
- **Action:** Choose M2.5 inserts vs nut-capture; pick standoff height as part of internal stack-up.

### F8  (High · Open · Sensing / Scope)
- **Flag:** Order adds IMU + air-quality + 2 mics + reed + mux — large expansion past locked camera+ToF+LED. Risk: front-loading all of it stalls v1.
- **Related:** 4632, 5626, 375, 4754, 3421
- **Action:** Sensor count ~10 modalities. Pick minimal v1 (camera+ToF+IMU); rest = plug-in library post-v1 (all STEMMA QT).

### F9  (Medium · Open · Sensing / Firmware)
- **Flag:** I2S mic uses Pi PCM peripheral; WS2812-style LED band driven via PCM collides with it.
- **Related:** 3421; LED band
- **Action:** Drive LED over SPI/PWM (not PCM). Cleanest: hand WS2812 to the KB2040 (PIO) - see F11.

### F10  (Medium · Open · Sensing)
- **Flag:** BNO085 has documented I2C clock-stretching trouble on Raspberry Pi.
- **Related:** Adafruit 4754; Pi 3
- **Action:** Run BNO085 in UART-RVC or SPI mode, or budget I2C bring-up time.

### T1  (Tool note · Open · Wiring)
- **Flag:** Heat-shrink + XT60 solder work need a heat gun; unknown if one is owned.
- **Related:** Ginsco kit
- **Action:** Confirm a heat gun is on the shelf; add to acquire list if not.

### Q1  (Question · Open · Power)
- **Flag:** Exact XT60H pair count not confirmed from photo.
- **Related:** XT60H
- **Action:** Count the bag; update Qty.

### Q2  (Question · Open · Compute)
- **Flag:** Geekworm standoff kit: 1 or 2 boxes?
- **Related:** Geekworm
- **Action:** Confirm; update Qty (currently tentative 2).

### Q3  (Question · Open · Sensing)
- **Flag:** Two BNO085s: body+ridge (independent ridge orientation) or 1 + spare?
- **Related:** Adafruit 4754
- **Action:** Confirm intent; sets whether 2nd IMU is a build item or backup.

### C1  (— · Closed · Power)
- **Flag:** Inline fuse holder needed.
- **Related:** Fuse holders
- **Action:** Closed — 10 in hand.

### C2  (— · Closed · Power)
- **Flag:** Balance charger needed.
- **Related:** SKYRC B6AC
- **Action:** Closed — B6AC V2 in hand.

### C3  (— · Mitigated · Power)
- **Flag:** Pack puffing if stored at full charge across weekends.
- **Related:** Zeee; B6AC
- **Action:** Mitigated — use charger STORAGE mode (3.8V/cell). Lives on as a habit.

### C4  (— · Closed · Power)
- **Flag:** Connector match between pack and interconnect.
- **Related:** Zeee; XT60H
- **Action:** Closed — pack ships XT60, matches XT60H.

### F11  (Medium · Open · Compute)
- **Flag:** KB2040 (RP2040) arrived (free). Could be the real-time co-processor for Layer-1 reflex + encoder counting + WS2812/I2S offload - or a spare.
- **Related:** Adafruit 5302; Pi 3
- **Action:** Decide compute topology: Pi + RP2040 co-pro, or Pi-only. If co-pro, it cleanly resolves F9 and reflex timing.

### F12  (Medium · Open · Sensing)
- **Flag:** I2C address management as device count grows. 2x DS3231 share FIXED 0x68 -> collide on one bus.
- **Related:** DS3231 x2; mux; hub
- **Action:** Map every I2C device to bus/mux channel. Colliders (ToF, 2nd RTC) -> separate mux channels; unique-addr -> hub.

### Q4  (Question · Resolved · Sensing)
- **Flag:** Magnetic sensing intent: 2x DRV5032 Hall + 4x Adafruit reed (375) + ~20 glass reed (E383) all overlap. No defined v1 magnetic job.
- **Related:** 6051; 375; E383 reeds
- **Action:** RESOLVED: No magnetic sensor in v1 (core=cam+ToF+IMU per F8). DRV5032 Hall = sensor-of-record for on-chassis magnetics (module-ID, v1.5) - solid-state, vibration-immune. Reeds = library/spare; one good future job = ZERO-POWER dock-presence detect IF a charging dock is added (v1.5+). Reeds parked, not orphaned.

### F13  (Medium · Open · Power)
- **Flag:** 5V rail budget: D24V22F5 is 2.5A. Pi 3 active ~0.7-1A; addressable LED band can add ~1A (WS2812 ~60mA/LED at white) + sensors.
- **Related:** D24V22F5; Pi 3; LED band
- **Action:** Budget the 5V rail; cap LED count/brightness or move LED band to its own supply if needed.

### F14  (High · Open · Compute)
- **Flag:** Abrupt power-off (kill switch / pack cutoff) can corrupt the Pi's microSD (ext4 on yank).
- **Related:** Pi 3; microSD; ADS1115
- **Action:** Use F3's pack-V sense to trigger a GRACEFUL shutdown before cutoff; and/or run a read-only root filesystem.

### F15  (Medium · Open · Compute / Chassis)
- **Flag:** Pi 3 runs warm under vision load; sealed printed body may throttle it.
- **Related:** Pi 3; chassis
- **Action:** Fit kit heatsinks; provide airflow (service hatch as vent / vent slots) in body design.

### Q5  (Question · Open · Compute)
- **Flag:** Pi 3 model: B or B+? (affects WiFi band + thermals, minor).
- **Related:** Pi 3
- **Action:** Confirm from board silkscreen.

### F16  (Opportunity · Open · Sensing / Behavior)
- **Flag:** Reflex layer (Layer-1, sub-100ms) wants dumb/fast/no-bus sensors - wrong job for I2C gear. 37-in-1 kit supplies them.
- **Related:** 37-in-1 kit; KB2040
- **Action:** Use kit IR-reflectance (cliff/edge) + shock/tilt (impact/tip) read directly by KB2040 for a deterministic reflex loop, independent of Pi/I2C.

### F17  (Medium · Open · Sensing / Chassis)
- **Flag:** PIR invalid while moving (field change -> constant false triggers). Also: LWIR (8-14um) won't pass printed PETG/ASA shell, so Fresnel domes must be exposed - protrusions vs no-anthropomorphism spine.
- **Related:** HC-SR501 x5; encoders/IMU; shell
- **Action:** Use PIR as at-rest presence-attention only: gate output on zero-velocity (encoders/IMU). Design dome openings into shell now. Reframe: stillness-gated 'other present' significance.

### Q6  (Question · Open · Sensing)
- **Flag:** Five PIRs: perimeter array for omnidirectional at-rest coverage, or spares?
- **Related:** HC-SR501 x5; KB2040
- **Action:** If array: 5 GPIO (consider KB2040, or OR down to 'presence anywhere' if bearing not needed).

### F18  (Medium · Open (v1.5) · Actuation / v1.5)
- **Flag:** v1.5 camera-articulation servo selection. 10x SG90-class 9g analog (Smraza S51) in hand - ideal for prototyping the pan/tilt mechanism + geometry. Open questions for the FLIGHT build: analog 9g jitter/buzz conflicts with QD's deliberate legible-motion premise; plastic gears back-drive/strip on shock-load.
- **Related:** Smraza S51 9g servo x10; camera ridge; F13 (5V rail)
- **Action:** Prototype articulation on these. For flight, evaluate digital metal-gear micro servo (smooth/quiet/repeatable holds, gear robustness). Put 2x servos on a dedicated buck/rail w/ decoupling - add stall current to F13 budget. Decide PWM source (Pi sw-PWM jitters -> consider PCA9685). Confirm pan throw: +-120 needs linkage ratio vs ~180deg servo. Keep servo PWM in BODY (ridge connector is sensor-only, per F6).

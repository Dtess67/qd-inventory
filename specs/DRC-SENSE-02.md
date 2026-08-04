# D/R/C-SENSE-02 — Complete Stage-1 Sensor Lineup

> **Status:** RATIFIED by Darrell on 2026-08-04 with “Make it so. Love it.” Pressure-tested by Claude through Sensing Architecture Revision 3. Drafted into the record by Q.
>
> **Scope:** QD Stage 1 — The Carried Observer.

## Decision

QD Stage 1 shall use the following complete sensory capability set. Exact part substitutions require equivalence review, but no category below may silently disappear.

### A. External perception

1. **Stereo vision — two matched real cameras**
   - Raspberry Pi Global Shutter Camera class, IMX296
   - matched 6 mm lenses as the current target
   - fixed rigid pair
   - optical baseline target: **55–65 mm**
   - synchronized capture on one monotonic timebase
   - real lenses centered inside visibly expressive iris assemblies

2. **Paired ranging — two VL53L4CD ToF sensors**
   - one left and one right near the stereo eyes
   - separate flush optical windows and matte-black baffles
   - sequential firing to prevent crosstalk
   - used to confirm exact range and surface orientation, not replace stereo depth

3. **Directional hearing — four microphones**
   - two visible ears
   - two microphone elements per ear
   - known rigid geometry
   - mechanical isolation from shell, straps, hardpoint, cooling system, and speaker
   - acoustic wind protection / pinna function
   - reserved speaker-loopback reference for echo cancellation
   - independent visible microphone state and a physical mute switch

4. **Environmental sensing — one BME688 intake**
   - temperature
   - relative humidity
   - barometric pressure
   - gas-resistance / air-quality pattern sensing
   - front snorkel-style intake
   - thermally isolated from Pi 5 and enclosure exhaust

### B. Body-state and motion perception

5. **Inertial sensing — one BNO085 IMU**
   - acceleration
   - angular motion
   - magnetic heading
   - fused orientation
   - motion state associated with every camera, audio, ToF, and environmental record

Its primary interpretive purpose is to distinguish:

> **The world moved** from **Darrell moved me.**

### C. Human-interaction sensing

6. **Crown capacitive touch strip**
   - deliberate touch and acknowledgement input
   - positioned away from ordinary carrying grips to reduce false triggers

7. **Physical privacy-state sensing**
   - shutter position must be electrically known as open, closed, or fault/unknown
   - microphone mute-switch state must be electrically known
   - software may never report visual or audio availability contrary to the physical state

### D. Interoception / physical self-monitoring

QD shall monitor her own operating condition. The capability is ratified; exact component choices remain an implementation decision.

Required telemetry:

- Pi 5 processor temperature
- enclosure / internal-air temperature
- supply voltage
- current draw
- undervoltage state
- thermal-throttling state
- power-bank status when electronically available
- cooling-fan command and tachometer state if active cooling is selected

These signals form Stage-1 interoception: evidence about the condition of the body through which QD interacts.

## Spatial interpretation stack

The Stage-1 directional architecture is:

> **Two eyes to see depth.**  
> **Two ears, with four microphones, to locate sound.**  
> **Two ranging points to confirm distance.**  
> **One IMU to separate external motion from carried motion.**  
> **One environmental nose to sense changes humans cannot directly see.**

Multimodal fusion must retain the evidence, uncertainty, timestamps, and failure state of each modality. No fused conclusion may erase disagreement between sensors.

## Sensor Honesty requirements

- Visible gaze reports the attention layer, not fictional physical camera aim.
- Expressive iris components may surround but may not obstruct real lenses.
- Stillness when idle; no decorative wandering-eye script.
- Eyelid closure physically covers both camera and both ToF apertures.
- No camera or ToF sensor may remain active while the face communicates closed eyes.
- Microphones use a separate visible active/muted state and physical mute switch.
- A failed or indeterminate shutter/mute state must be shown as unknown, never guessed safe.

## Consequences

1. A second matched IMX296 global-shutter camera and matching lens enter the Stage-1 BOM.
2. A four-channel microphone front end with onboard or dedicated DSP is required.
3. The two ToF sensors already in inventory become the left/right range pair.
4. All cameras, ToF sensors, microphone-ear bases, BNO085 reference, and carry hardpoint share one rigid internal sensing chassis.
5. Timestamp synchronization, calibration storage, and sensor-health reporting become core software infrastructure.
6. Pi 5 power, thermal, and acoustic behavior must be validated with the complete sensor set installed.
7. Internal voltage/current/enclosure-temperature hardware must be selected before final wiring and CAD release.

## Deferred — not Stage-1 locked

The following remain possible later additions and may be evaluated as coupon-class experiments:

- GNSS / GPS
- thermal camera or stereo thermal pair
- mmWave radar
- ambient-light and ultraviolet sensing
- PMS5003 or other particulate sensing
- distributed shell touch/contact sensing
- additional external environmental probes
- redundant IMU for fault detection

Their absence does not reduce the ratified Stage-1 lineup above.

## Verification gates

- both cameras capture concurrently with usable synchronization
- stereo calibration and depth tests pass at near, conversational, room, and outdoor distances
- both ToF units operate sequentially without unacceptable crosstalk
- four-channel audio localization is tested during speech, walking, wind, strap rub, cooling, and speaker playback
- BNO085 motion tags align with all sensory records
- BME688 readings are shown not to be dominated by internal Pi heat or exhaust
- touch input false-trigger rate is measured during real carrying
- shutter position and microphone mute state are electrically verified
- all required interoceptive telemetry is logged and threshold-tested
- sensor disagreement and failures remain visible in the evidence record

## Receipts doctrine

Earlier single-camera, two-microphone, Pi 3, and rover-first concepts remain valid historical branches. They are superseded for Stage 1 by this ratified lineup, not erased.
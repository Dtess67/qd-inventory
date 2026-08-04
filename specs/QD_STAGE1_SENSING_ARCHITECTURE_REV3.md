# QD_STAGE1_SENSING_ARCHITECTURE_REV3

> **Status:** Revision 3 sensing architecture. Compute and fixed-stereo gates ratified by Darrell on 2026-08-04 in `DRC-COMPUTE-01.md` and `DRC-SENSE-01.md`. Principles and locked constraints below are the current Stage-1 design basis. Experimental items remain coupon-class until separately ratified.
>
> **Embodiment:** QD Stage 1 — The Carried Observer.

## 1. Core spatial architecture

QD uses three complementary directional systems:

1. **Two eyes that see** — rigid synchronized stereo cameras.
2. **Two ears that hear** — four microphones arranged as two visible ear pairs.
3. **Two ranging points that confirm** — left/right VL53L4CD time-of-flight sensors.

Fusion must retain the evidence, uncertainty, timestamps, and failure state of each modality rather than collapsing them prematurely into one unquestioned answer.

---

## 2. Ratified principles

### 2.1 Visible Gaze Principle

> QD’s visible gaze reports active attention, not sensor aim.

Expressive components may surround the real camera lenses, but they must never:

- obstruct sensing,
- contradict the actual attention state,
- imply that fixed cameras physically turned,
- animate from a decorative script while the system is idle.

**Stillness when idle.**

### 2.2 Sensor Honesty Principle

> No sensor may be active while its visible form communicates that it is closed.

The eyelid-style visual shutter must visibly and physically cover:

- both camera apertures,
- both ToF apertures.

Microphones require:

- an independent visible active/muted state,
- a physical mute switch.

The exact authority policy for closing the shutter remains separately governable, but visible state and real sensor state may never disagree.

### 2.3 Binaural Attention Principle

QD has two visibly identifiable ears, each containing two microphones, producing a four-microphone array with known geometry.

The ear system must be:

- mounted high and wide,
- mechanically decoupled from the shell,
- isolated from strap and hardpoint loads,
- separated from the speaker,
- protected from wind.

The ear shape may serve as part of the windscreen. The audio path reserves a loopback/reference channel for echo cancellation.

### 2.4 Multimodal Spatial Confirmation Principle

QD should not depend on one sensing method when independent modalities can confirm or challenge the same spatial interpretation.

Stereo vision, directional hearing, inertial state, and paired ranging are fused while preserving their individual evidence and uncertainty.

### 2.5 Sensor Duplication Rule

> Duplicate a sensor only when known separation creates meaningful spatial information, necessary coverage, or fault detection.

Duplication is not justified merely by symmetry or appearance.

---

## 3. Locked Stage-1 sensing constraints

### 3.1 Compute

- Raspberry Pi 5 is the primary Stage-1 onboard computer.
- Pi 3 is retained for bench/test duty.
- Compute placement may be hybrid; capture integrity remains onboard-critical.

### 3.2 Stereo eyes

- two matched Raspberry Pi Global Shutter Camera modules, IMX296 class,
- matching lenses, currently 6 mm target,
- fixed rigid pair,
- optical baseline target: **55–65 mm**,
- no Stage-1 camera pan/tilt,
- both modules mount to one rigid internal chassis,
- all frames use one monotonic timebase,
- BNO085 motion state tags every frame.

Each lens is centered within a visible illuminated iris assembly. The visible iris expresses attention and state around—not through—the optical path.

### 3.3 Dark face panel and optical paths

The former shared visor is replaced by a **dark face panel** that reads visually as one face.

Each camera and each ToF sensor receives:

- its own flush optically clear window,
- AR coating where practical,
- a matte-black baffle/tunnel,
- no shared optical air gap with illuminated eye components.

Illuminated iris elements remain outside the baffles. Eye brightness automatically reduces in darkness.

### 3.4 Eyelid privacy closure

The eyelid-style closure must cover the camera and ToF apertures together.

Required visible states:

- fully open,
- fully closed,
- fault/unknown state that does not falsely communicate privacy.

Caption/requirement:

> **When she isn’t looking, she can’t look.**

### 3.5 Paired ToF ranging

- VL53L4CD ×2,
- mounted left/right near the stereo eyes,
- separate flush optical windows,
- sequential firing using XSHUT control or an appropriate I²C isolation/control arrangement,
- the approximately 18-degree field/cone limitation documented in the mechanical and sensing specifications.

Their purpose is exact left/right range confirmation and surface-orientation evidence, not a replacement for stereo vision.

### 3.6 Four-microphone ears

- two visible ear housings,
- two microphone elements per ear,
- known fixed geometry,
- isolation grommets or equivalent mechanical decoupling,
- foam/acoustic wind protection,
- speaker-reference loopback reserved for echo cancellation,
- visible microphone state,
- physical mute switch.

Beamforming/audio DSP must run on an audio front end or dedicated/offloaded path rather than consuming unbounded application-core time.

### 3.7 One sensing chassis

The following mount to one rigid internal frame:

- both cameras,
- both ToF sensors,
- both ear bases,
- BNO085 datum/reference,
- universal rear carry hardpoint.

Strap loads transfer through this frame, not through the shell or removable service panel.

Caption/requirement:

> **One frame. Fixed geometry. Honest fusion.**

---

## 4. Carry/body constraints retained from Revision 2

- compact rounded warm-white shell, approximately 180–200 mm tall,
- comfortable single-hand hold,
- chest/front carry as primary carried observation mode,
- hip sling as secondary transport mode,
- charging perch as primary stationary observation mode,
- flat stable base,
- universal recessed rear hardpoint attached to internal chassis,
- removable rear service panel with load path bypass,
- crown touch strip,
- visible physical power switch,
- BME688 front snorkel thermally isolated from internal electronics,
- conversational lower-front speaker,
- low side intake and crown exhaust path,
- no rear vents blocked by chest carry,
- expression ring with color plus pulse-pattern redundancy.

Pi 5 thermal output requires the vent geometry and active/passive cooling choice to be recomputed before enclosure CAD is released.

---

## 5. Attention behavior

The face must provide at least these truthful attention states:

1. **Idle:** still and dim; no decorative wandering.
2. **Attending left/right/up/down:** iris/pupil display indicates the attention-layer direction while fixed sensors continue wide capture.
3. **Tracking localized sound:** ear state shows localization activity; gaze display converges toward the selected sound direction after evidence supports it.
4. **Uncertain:** expression communicates unresolved interpretation without pretending certainty.
5. **Privacy closed:** camera and ToF apertures physically blocked; microphones independently indicate active/muted state.

The system must not imply direct eye contact or tracking unless the attention layer has actually selected that person or target.

---

## 6. Experimental forks — coupon-class only

The following must be prototyped independently and may not be baked into the main structure until tested:

- iris display technology,
- brow mechanism,
- ear/pinna geometry,
- shutter actuation mechanism and materials,
- exact optical-window material/coating,
- exact audio-front-end board,
- passive versus active Pi 5 cooling.

---

## 7. Required acceptance tests before sensing-chassis CAD release

1. Camera baseline and optical axes measured from real hardware.
2. Matched stereo capture and monotonic timestamps demonstrated.
3. Stereo depth tested at near, conversational, room, and outdoor ranges.
4. ToF pair sequential operation tested for crosstalk and cover-window effects.
5. Four-mic geometry tested during chest carry, walking, wind, speech, strap rub, fan operation, and speaker playback.
6. Echo-cancellation reference path demonstrated.
7. Chassis deflection under carry load shown not to invalidate stereo/audio extrinsics.
8. Shutter closed state electrically proves camera and ToF inactivity/unavailability.
9. Microphone physical mute state electrically proves audio capture is disabled.
10. Visible gaze and ring states shown to match logged attention/system state.
11. Pi 5 thermal soak completed in carried and perched modes.
12. No locked feature may silently disappear from the Rev-3 render or CAD.

---

## 8. Render acceptance language

Required concept-sheet captions:

- **Carried to travel. Perched to observe.**
- **Two eyes that see. Two ears that hear. Nothing that pretends.**
- **The shutter is hers to close.**
- **When she isn’t looking, she can’t look.**
- **One frame. Fixed geometry. Honest fusion.**

The concept render is communication evidence, not dimensional authority. Real geometry enters through measurements and `V1_CAD_GATE_MEASUREMENTS.md`.

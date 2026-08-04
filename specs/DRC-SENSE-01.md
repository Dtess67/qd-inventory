# D/R/C-SENSE-01 — Fixed Stereo Geometry for Stage 1

> **Status:** RATIFIED by Darrell on 2026-08-04. Pressure-tested by Claude. Drafted into the record by Q.
>
> **Scope:** QD Stage 1 — The Carried Observer.

## Decision

QD Stage 1 uses a **fixed, rigid stereo-camera pair** with a target optical baseline of **55–65 mm**.

No physical camera pan/tilt mechanism is included in Stage 1.

QD’s visible expressive gaze reports the direction and target of her **active attention**, not a false claim that the fixed camera lenses have physically rotated.

## Reason

A rigid stereo pair provides useful binocular depth for faces, room-scale observation, object separation, and later transfer into mobile embodiments while preserving calibration.

The current design estimates indicate that a baseline in this range can provide approximately:

- millimeter-scale depth sensitivity near 1 m,
- centimeter-scale sensitivity at a few meters,
- coarse depth at longer outdoor distances.

These are design estimates, not acceptance guarantees; actual performance depends on focal length, resolution, exposure, texture, lighting, calibration, synchronization, and the stereo algorithm.

A gimbal inside a frequently carried and handled childhood body would add:

- mechanical fragility,
- mass and power draw,
- acoustic noise,
- moving-cable failure points,
- repeated extrinsic-calibration risk,
- conflict between protective shutter geometry and moving optics.

Fixed wide stereo therefore gives Stage 1 the cleaner evidence path. Physical foveation may be reconsidered in Stage 2 after QD has learned to perceive and direct attention.

## Consequence

1. Both camera modules, both ToF sensors, microphone-ear bases, BNO085 reference, and the rear carry hardpoint mount to **one rigid internal sensing chassis**.
2. Camera baseline becomes a measured CAD gate and must remain within the ratified range after lens/window/baffle packaging.
3. The two cameras require matched sensor/lens configuration, rigid extrinsics, synchronized capture, and repeatable calibration.
4. The visible iris/gaze display must be driven from the attention layer’s actual selected target or direction.
5. Scripted eye animation while QD is idle is prohibited. **Stillness when idle.**
6. The gaze display may shift, converge, widen, blink, or show focus only when those movements truthfully represent attention, uncertainty, acknowledgement, privacy, or another defined system state.
7. Pan/tilt is deferred to **Stage 2 foveation** and must not be silently added to the Stage-1 structure.

## Verification gates

- physical baseline measured and recorded,
- camera optical axes and chassis datum recorded,
- stereo calibration remains within tolerance after carry/handling tests,
- frame synchronization demonstrated,
- depth tested at near, conversational, room, and outdoor ranges,
- visible gaze correctly reports the attention-layer target in controlled tests,
- idle-state eye behavior remains still and non-deceptive,
- privacy closure visibly and physically blocks both cameras and both ToF apertures.

## Receipts doctrine

The earlier pan/tilt concept remains a valid exploratory branch for later embodiment. It is deferred, not disproved.

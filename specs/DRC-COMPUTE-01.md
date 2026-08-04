# D/R/C-COMPUTE-01 — Stage-1 Compute Platform

> **Status:** RATIFIED by Darrell on 2026-08-04. Pressure-tested by Claude. Drafted into the record by Q.
>
> **Scope:** QD Stage 1 — The Carried Observer.

## Decision

The Stage-1 compute platform is **Raspberry Pi 5**, replacing Raspberry Pi 3 as the primary onboard computer.

The spoken approval — **“Pi 5, no problem”** — is superseded by this repository record and is no longer chat-only.

## Reason

Stage 1 now requires a substantially heavier synchronized perception workload than the rover-first plan:

- two-camera stereo capture,
- four-microphone directional-audio processing,
- sensor synchronization and monotonic timestamping,
- BNO085 motion tagging,
- local attention and surfacing behavior,
- room for later on-device novelty processing.

The Pi 3 has only one native CSI camera interface and insufficient practical headroom for the intended stereo-plus-audio workload. The Pi 5 provides two camera/display interfaces and materially greater compute capacity, making it the minimum sensible baseline for this architecture.

This decision does **not** require all perception inference to run onboard. The final compute placement may still be hybrid: real-time capture and light processing onboard, with heavier analysis streamed or batched elsewhere.

## Consequence

1. **Pi 3 is demoted to bench/test duty.** It remains useful and is not discarded.
2. A **second Raspberry Pi Global Shutter Camera using the IMX296 sensor and matching 6 mm lens** enters the Stage-1 BOM, subject to exact part-match and availability verification before purchase.
3. The enclosure thermal budget must be recomputed for Pi 5 power and heat output.
4. Vent area, air path, heatsink/fan choice, acoustic contamination, and chest-contact heating become CAD-gating concerns.
5. The power system moves to a USB-C power-bank architecture sized for Pi 5 peak demand and attached sensors.
6. The current planning allowance is approximately **$130 additional BOM**, but this remains a purchasing estimate until the BOM is quoted and locked.
7. The software architecture must reserve compute for capture integrity first; application inference may not starve camera, audio, timestamp, or logging paths.

## Verification gates

This decision is implemented only when the following pass:

- both cameras enumerate and capture concurrently,
- synchronized frame timestamps are demonstrated,
- four-channel audio capture/DSP runs without dropping sensory records,
- Pi 5 temperature remains within the chosen operating limit during a carried-body thermal soak,
- power-bank and cable sustain the full system without undervoltage,
- fan and regulator noise do not invalidate microphone performance.

## Receipts doctrine

The Pi 3 work remains true for the earlier rover architecture. It is re-sequenced, not erased.

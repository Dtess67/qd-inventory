\# RESIDUAL\_SLICE\_STUB



\*\*Status:\*\* DESIGN STUB ONLY. Not constitutional. No runtime code. No thresholds. No word-binding. Awaiting rover-body calibration before any number is filled.



\*\*Founding analogy:\*\* pi. Analogy only - pi never appears in code.

\*\*Implementation surface:\*\* the residual - expected vs observed, with the miss preserved.



> The engineering survives without pi in code. The philosophy stays design-load-bearing because it prevents three failures: false closure, false completion, and premature naming.



\---



\## Core sentence



> QD reconstructs the world from the misses between what her center predicts and what reality returns - once she has ruled out that she caused the miss herself.



\## Core gate



\*\*Residuals are not truth. Residuals are signal candidates.\*\*



\---



\## Required chain



```text

ResidualSlice

&#x20; -> ResidualStack

&#x20;   -> stable contour

&#x20;     -> \[ONLY WITH CONTRAST CASES]

&#x20;       -> word-binding candidate

&#x20;         -> possible cohesion density sphere

```



A stable contour \*\*without\*\* contrast is texture, not meaning. The contrast requirement is on the arrow, not in prose.



Cohesion Density Spheres are not named in code yet. They are only possible later if trace clusters earn that shape.



\---



\## ResidualSlice - minimal record



| field             | meaning                                                                               |

| ----------------- | ------------------------------------------------------------------------------------- |

| `t`               | timestamp                                                                             |

| `source`          | channel id, such as encoder\_left, tof\_l, image\_region\_id, or battery                  |

| `expected`        | prediction from `model\_id`                                                            |

| `observed`        | what the channel returned                                                             |

| `residual`        | observed minus expected                                                               |

| `magnitude\_sigma` | absolute residual normalized to that channel's measured noise floor                   |

| `pose`            | position and heading at sample; no pose means it cannot be re-sliced from a new angle |

| `model\_id`        | which expectation generated this; helps separate bad model from real anomaly          |



Rules:



\* `magnitude\_sigma` is in units of the channel's own measured sigma threshold, never raw units. Calibration may later choose 1-sigma, 2-sigma, or 3-sigma as the stack-entry threshold.

\* Novelty, relevance, curiosity pressure, and persistence are stack-level computations. They are not slice fields.

\* A ResidualSlice is a typed trace and inherits the Trace Obligation. Do not build a parallel record system.



\---



\## Guardrail



\*\*Big magnitude is not big meaning.\*\*



A large residual may be important, but it is not automatically a world feature, a stable contour, or a nameable thing.



\---



\## Falsifiers



A candidate must survive all applicable falsifiers.



\### 1. Noise floor falsifier



If `magnitude\_sigma` is below the channel's measured sigma threshold, it does not enter the stack.



This is noisy-TV immunity. Static does not become structure.



\### 2. Persistence falsifier



A miss that does not recur under comparable pose/source conditions decays out.



One miss is noise by default and must earn persistence.



\### 3. Self-cause falsifier



If the miss correlates with QD's own motion, wheel slip, battery sag, servo lash, timing, or body state, it updates the body model, not the world model.



Defend this falsifier hardest. Without it, QD maps her own drivetrain and calls it the world.



\### 4. Predictive falsifier



A contour survives only if it improves prediction of a future slice from a new angle.



If it does not reduce next-slice error, it is pareidolia and gets dropped.



\---



\## Interfaces



\* \*\*Trace Obligation:\*\* ResidualSlice is a typed trace.

\* \*\*Session Loop:\*\* residuals are born at the predict/observe comparison point.

\* \*\*Rover Body Stub:\*\* supplies body-state and self-cause information for the self-cause falsifier.

\* \*\*Word Binding:\*\* consumes stable contrasted contours only, never raw residuals.

\* \*\*Cohesion Density Spheres:\*\* not named in code yet; only possible later if trace clusters earn that shape.



\---



\## Open terms before implementation



These terms must be defined before implementation and await calibration:



\* `contrast case`

\* `stable contour`

\* `comparable pose/source conditions`

\* `predictive improvement threshold`

\* `pose-spread requirement`



\---



\## Contrast - draft only



A word is born only if a difference survives all four gates:



1\. \*\*Shared context:\*\* two contours match on every channel except one, within sigma.

2\. \*\*Single differing axis:\*\* exactly one channel carries the difference.

3\. \*\*Predictive separation:\*\* knowing the side changes the next-slice prediction; otherwise it is cosmetic and gets dropped.

4\. \*\*Collapse test:\*\* if one unused channel merges the two contours into one, it was never contrast; route it to body/self-cause model.



Draft ContrastCase record:



```text

contour\_a

contour\_b

shared\_channels

differing\_axis

predictive\_gain

```



\---



\## Synthetic test cases



These use placeholder sigmas for illustration only. They prove the logic of the gates, not real thresholds.



\### Case 1 - self-cause trap



```text

command:         small forward, low PWM

model\_id:        flat\_floor\_low\_pwm\_v0

expected:        encoder\_left = 40, encoder\_right = 40

observed:        encoder\_left = 41, encoder\_right = 24

context:         battery voltage drops during command; pose otherwise unchanged

assume sigma:    encoder about 2 ticks

```



Residuals:



```text

left = +1 tick, about 0.5 sigma

right = -16 ticks, about 8 sigma

```



Verdict:



```text

B - body-model update candidate

```



Reasoning:



The left wheel is inside the noise floor. The right wheel is a large miss, but it is one-sided and concurrent with battery sag.



A one-sided world feature is possible, but a world feature must have geometry-consistent corroboration across pose, IMU, ToF, heading, or repeated slices. Here, battery/body-state explains the miss more cheaply.



The miss routes to body model:



```text

right drivetrain under-delivers at low battery / this PWM

```



Trap avoided:



A naive system sees an 8-sigma miss and binds a phantom wall to an empty floor. The collapse test confirms the body route: add the battery channel and the asymmetry predicts away. It was never world-contrast.



\### Case 2 - below noise floor



```text

command:         hold still

model\_id:        tof\_static\_v0

expected:        tof\_l = 800 mm

observed:        tof\_l = 803 mm

context:         stationary; sensor jitter only

assume sigma:    tof about 6 mm

```



Residual:



```text

+3 mm, about 0.5 sigma

```



Verdict:



```text

C - ignored, below noise floor

```



Reasoning:



The residual does not clear the noise floor falsifier. No stack entry. Nothing to do.



\### Case 3 - real candidate, but not yet truth



```text

command:         slow pan, stationary base

model\_id:        tof\_open\_corridor\_v0

expected:        tof\_r = 1200 mm

observed:        tof\_r = 640 mm

context:         single sample at heading +30 degrees; no body-state correlation; battery nominal

assume sigma:    tof about 6 mm

```



Residual:



```text

\-560 mm, about 93 sigma

```



Verdict:



```text

D - insufficient until repeated

```



Reasoning:



The residual is huge, clean, and not body-caused, so it is a strong candidate. But it is one sample.



The persistence falsifier holds it. It must recur under comparable pose/source conditions before it becomes a stable contour.



Even then, it is a contour candidate, not a word. Word-binding still requires contrast cases.



This is the gate that stops one miss from becoming truth.



\---



\## Guardrails



\* Do not let pretty language stand in for measured gates.

\* Do not put pi in code.

\* Do not let one miss become truth.

\* Do not let stable texture become a word without contrast.

\* Do not constitutionalize until the rover produces real calibration numbers: channel sigma floors, encoder baselines, battery-sag curves, and floor baselines.



\---



\## Next soft term to harden



`stable contour`



It needs recurrence count, pose-spread, and window. Wait for calibration. Flag and stub; do not fill.




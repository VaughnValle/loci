---
tags:
  - haptics
---
_by Vaughn Valle_

### Two-Channel Transparent Telerobotic Architecture

Mass and damping of $Z_e$  model was modified to $3 kg$ and $3\frac{N\cdot s}m$
![[Pasted image 20241029201416.png]]

Likewise, Mass and damping of $Z_h$  model was modified to $3 kg$ and $3\frac{N\cdot s}m$
![[Pasted image 20241030133757.png]]

Lastly, I made sure that the interactive Force function $f_h$ is of the form
$$
f_h=20sin(1t) + 20cos(2t) + 20sin(10t)
$$

![[Pasted image 20241030134104.png]]
However, when run, the program fails with an algebraic loop error
![[Pasted image 20241030140031.png]]

One potential issue could be that in the Homework PDF, the $Z_e$ and $Z_h$ values were swapped. Since the value of $Z_h$ is too low, then Add1 module fails. In Homework 1, it was $Z_e$ that had an incredible low value so it is likely that this was a typo error. Swapping the values does the trick.

Below is the plot for the force experienced of the environment side in comparison to the leader robot.
![[Pasted image 20241030140316.png]]

Additionally, we also plot the velocity between the follower robot and compare it against the velocity of the leader robot.
![[Pasted image 20241030140331.png]]
### A) Mathematically explain if you believe the system should be stable or not.

First of all, it is important to keep in mind the graphs from the previous HW1 shown below
![[Pasted image 20241012125903.png]]
![[Pasted image 20241012125848.png]]
![[Pasted image 20241030140316.png]]

![[Pasted image 20241030140331.png]]
When compared, the current plots are significantly smoother. However, the plots of velocity have significant deviations from the environment side to the leader robot side. There is a small amount of phase shift and amplitude is lost in the environment side.

The provided plots suggest a stable system. The oscillatory behavior with decreasing amplitude in both the force and velocity plots indicates a damped system, where oscillations gradually diminish over time. This is a characteristic of stable systems, as their outputs remain bounded for any bounded input. And this is shown in the given plots where it is smooth and dampened. The oscillatory behavior hints at complex poles in the system's transfer function, and the decreasing amplitude implies that the real part of these poles is negative. For linear time-invariant systems, negative real poles are a fundamental condition for stability.

However, it's crucial to consider potential complexities. This is all made with the assumption that the system is linear and time-invariant. If the system exhibits non-linear behavior, the analysis becomes more intricate, as non-linear systems can display diverse behaviors like limit cycles and chaotic oscillations. Additionally, time-varying parameters can further complicate stability analysis.

#### Update (After speaking with Peter Paik in my Lab Makeups)
![[Pasted image 20241031143541.png]]
![[Pasted image 20241031143553.png]]

We notice the significant Force feedback dip while Velocity on both follower and leader side spike to infinity at around $9\cdot10^{-3}$ seconds. This is because $Z_e$ is greater than $Z_h$. Thus, we see the algebraic error we saw awhile ago.

![[Pasted image 20241030140031.png]]

### B) Apply Wave-Variable control. Is the system stable? Explain why.

The goal of Wave-Variable control is to synchronize the motion of the follower and leader robot. By transmitting the desired trajectory of the master manipulator to the slave manipulator using a wave-like signal, the wave propagates through the communication channel, ensuring smooth and synchronized motion between the two systems.

Force Scope
![[Pasted image 20241102142143.png]]

Velocity Scope
![[Pasted image 20241102142044.png]]

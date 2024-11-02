---
tags:
  - haptics
date: October 4, 2024
---
_by Vaughn Valle_ 

### Question 1
A Two-Channel Transparent Telerobotic System was constructed from the given example
![[Pasted image 20241012120540.png]]
Mass damping models $Z_h$ and $Z_e$ parameters were modified accordingly
![[Pasted image 20241012120635.png]]
![[Pasted image 20241012120744.png]]

Finally, the human feedback response $f_h$ was setup using the addition of 2 sine wave functions and 1 cosine wave functions
$$
f_h^* = 20sin(1t) + 20cos(2t) + 20sin(10t)
$$
![[Pasted image 20241012121840.png]]
Once setup, we plot the velocity of leader ($V_h$) vs follower robot ($V_e$). 
![[Pasted image 20241012125903.png]]
We do the same thing but for the force experience by the leader robot ($F_h$) vs follower robot ($F_e$).
![[Pasted image 20241012125848.png]]

These graphs show that the system is actually promising. 
### Velocity Tracking
- The plots show a good correlation/relationship between the leader and follower velocities. The overall shape and trends of both curves follow each other, indicative of good transparency within the system for velocity.
- In terms of performance, the peaks and dips are not translated well on the environment side. Amplitude variations and slight phase differences are present so performance could definitely be improved for velocity tracking. Factors such as communication delay, noise, or the limitations of the control system itself could be the reason behind these negative effects.
### Force Tracking
- The force plots are spot on and very accurate. There is minimal latency/deviation between the leader and environment side of the system. 
- In terms of performance, the force graph shows minimal discrepancies between both sides. This indicated that force is being translated well from the leader robot to the follower.

Based on the provided plots, the system demonstrates good transparency and performance in force tracking. However, velocity tracking could be improved by addressing the aforementioned potential factors that cause the difference in amplitude and phase between leader versus follower.

In terms of stability, I think it's important to define what we mean by "stable" in this context. In control systems, stability refers to the system's ability to return to its equilibrium state after being perturbed. A stable system will eventually settle back to its original condition, while an unstable system will diverge from its equilibrium point. Based on the plots, my inference is that the system is stable. After a specific action is performed, the system will reach back to equilibrium since the only shortcoming we can see from the plots is that there is amplitude variation in velocity tracking, which is a non-issue unless the control system cannot adjust to the over/under correction from the inputs given.
### Question 2

#### Part A: Damper

A system is considered passive if the total energy stored in the system is non-negative for all time. For a damper, the force F(t) is related to the velocity V(t) by the equation:

$$
F(t)=BV(t)
$$

where $B$ is the damping coefficient.

The power input to the damper is given by:

$$P(t)=F(t)V(t)=BV(t)^2$$

Since $B$ is non-negative (assuming a physical damper), $P(t)$ is also non-negative for all $V(t)$. Therefore, the damper is passive.

To prove integral passivity, we need to show that the integral of the power input over any time interval is non-negative:

$$∫_{t_0​}^t​ P(τ)dτ=∫^t_{t_0}​BV(τ)^2dτ≥0$$

This inequality holds true since $BV(τ)2$ is always non-negative. Therefore, the damper is integral passive.

#### Part B: Spring

For a spring, the force $F(t)$ is related to the displacement $x(t)$ by Hooke's law:

$$F(t)=−kx(t)$$

where $k$ is the spring constant.

The power input to the spring is given by:

$$P(t)=F(t)V(t)=−kx(t)\frac {dx(t)}{dt​}$$

We can rewrite this expression as:

$$P(t)=-\frac{d}{dt}​[\frac 1 2 ​kx(t)^2]$$

The integral of the power input over any time interval is then:

$$∫^t_{t0}​​P(τ)dτ=−∫^t_{t0}​\frac d {dt}​(\frac 1 2 ​kx(τ)^2)dτ=−[\frac 1 2​kx(t)^2−\frac 1 2​kx(t_0​)^2]$$

Since the potential energy stored in the spring is $\frac 1 2kx(t)^2$, the integral of the power input is equal to the change in potential energy. If the spring returns to its equilibrium position, the change in potential energy is zero, and therefore, the integral of the power input is non-negative. This shows that the spring is integral passive.
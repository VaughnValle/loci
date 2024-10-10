_by Vaughn Valle_

### Question 1



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

This inequality holds true since $BV(τ)^2$ is always non-negative. Therefore, the damper is integral passive.

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
---
tags:
  - telerobotics
---
Password : `ROB2021`

- Barriers between remote and control site
	- Distance
	- Danger
	- Different scale
	- Border between real and virtual world
- Teleoperation refers to the control of robotic machinery remotely
- Haptics is defined as a technology that transmits tactile information using sensations such as vibration, touch, and force feedback. 
	- Ability to provide sense of touch remotely
- Algorithms and mathematics that govern robotic behavior
	- [[Laplace Transform]]
	- A system is linear if it is [[Homogenous]] and [[additive]]
	- [[LTI Systems]]
	- Complex ratio
	- $\frac a c$ = DC GAIN
		- 1 for HPF
		- 0 for LPF
	- Band Pass filter
		- old radios
	- More experienced surgeons have more hand tremors
		- Low pass filter in telerobotics/surgical robotics important
		- Allows them to go beyond natural competence
	

> [!important]
> The whole goal of telerobotics is to overcome these barriers: being able to operate while not being present physically


- How do you balance and filter detail

## Performance and Transparency of Telerobotics Systems
- $Z(s)$ Impedance Model, input $v$, output $f$
	- $\frac f v$
- $Y(s)$ Admittance Model, input $f$, output $v$
- $H(s)$ Hybrid Model
- Echo factor $h_{11}(s) = \frac {f_h(s)}{v_h(s)}$ on leader side
	- Human would feel echo effect
	- if $h_{11}(s) = 0$, is fully transparent
		- is a characteristic of teleoperator
			- if high, terrible design, you feel yourself instead of the environment, echo effect
	- $h_22(s)$ is echo factor on follower side
## Ideal Hybrid Matrix
$f_h = h_{11}v_h + h_{12}f_e$
- ideally $h_{11}=0,h_{12}=1$
$f_h = f_e$ , [[Ideal Response]]
$-v_e=h_{21}v_h+h_{22}f_e$
- ideally $h_{21}=1,h_{22}=0$


ZTO
- impedence operator can feel

Design robot and controller to account for ideal hybrid matrix
$Z_mv_h = f_{hand} + f_{cm}$, internal and external force

Impedance is a characteristic of the robotic system
- describe how damp the robotic system is

Takeaway: we can change $f_{cm},f_{cs}$
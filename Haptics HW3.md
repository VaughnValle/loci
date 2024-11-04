---
tags:
  - haptics
---
_by Vaughn Valle_

## Human Hand Impedance Characteristics During Maintained Posture

### Introduction
The research paper's goal was to examine human hand impedance with the following characteristics: inertia, viscosity, and stiffness in multi-joint arm movements. It aims to gain a better understanding of the role of these hand impedance characteristics in motor control to provide insights for the development of more realistic biomechanical models and better replicate hand movements.

### Methodology
The study employed a two-joint planar direct drive robot as a manipulandum to apply small, short-duration disturbances to the subject's hand while they maintained a specific posture. The robot was programmed to apply a pre-determined disturbance pattern that returned to the initial position within a short timeframe to minimize the influence of voluntary responses. The researchers measured the resulting hand displacements and forces and used a second-order linear model to estimate hand impedance. The accuracy of this method was validated using a mechanical system with known parameters, such as brass weights and mechanical springs.

### Results
The study found that the estimated inertia matrices of the human hand closely matched those calculated using a two-joint arm model, confirming that basic biomechanics can explain hand inertia characteristics in multi-joint movements. The spatial variations of the stiffness ellipses were consistent with previous research, showing that hand stiffness depends on hand location and arm posture. Notably, the stiffness values obtained in this study were lower than those reported in prior research, possibly due to differences in the experimental setup and the fact that the subjects did not need to grab the handle in this specific study.

The study also revealed that hand stiffness and viscosity increase with grip force, suggesting that voluntary muscle activation contributes to these impedance components. Moreover, the orientations of the viscosity ellipses were found to be almost parallel to those of the stiffness ellipses, which implies that the hand's dynamic behavior is consistently damped across different movement directions.

### Discussion and Future Research
These findings highlight the importance of considering hand impedance in models of motor control. The researchers propose a framework that distinguishes five different representations of the time-varying end-effector point linked by neuromuscular processes, emphasizing the role of hand impedance in shaping actual movement trajectories.

Based on these findings, I think further research is needed to investigate how factors like muscle activation level, task instructions, and 3D arm postures influence hand impedance. This knowledge will contribute to a more comprehensive understanding of human motor control and aid in the development of more sophisticated and accurate biomechanical models for hand movement.

## Development of a Two-Axis Robotic Platform for the Characterization of Two-Dimensional Ankle Mechanics

This paper presents the design and validation of a two-axis robotic platform for characterizing ankle mechanics, particularly ankle impedance and energetic passivity. This platform is designed to simulate a wide range of haptic environments and apply controlled perturbations to the ankle in two degrees of freedom (DOF), enabling the study of ankle mechanics during various lower extremity tasks in realistic environments.

### Introduction
#### There is a Need for a Multi-Axis Robotic Platform

The demand for lower extremity robots, including exoskeletons, orthoses, and prostheses, has been steadily increasing in industrial, military, and clinical settings. Proper control of the ankle joint in these devices is **crucial for stable and effective physical interaction between the human and the robot**. Thus, understanding how human ankle mechanics work during different tasks is essential for developing improved control strategies for lower extremity robots. Existing control strategies for ankle joints are limited to controlled walking on level and rigid surfaces and cannot be readily generalized to more complex lower extremity functions.

#### Limitations of Prior Devices

Previous devices used to characterize ankle mechanics have limitations. Simple devices with a servo-controlled motor and a leg cast are restricted to stationary postures and a single DOF. Platform devices that rotate the footplate are also limited to static postures, single DOF movement, and a single mechanical environment. Wearable ankle robots allowed for the characterization of multi-dimensional ankle impedance and energetic passivity during both static and dynamic tasks but were unable to handle substantial loading at the ankle, like that experienced during mid- or terminal stance in walking or postural balance in standing. More recent robotic platforms have been designed to characterize ankle impedance during walking, but they operate in a single control mode (position or torque) and use perturbation profiles that do not allow for a thorough analysis of intrinsic and reflexive control dynamics.

The authors of this paper aimed to address these limitations by developing a multi-axis robotic platform capable of simulating a wide range of mechanical environments and actuating two DOF of the ankle with a variety of perturbation profiles.

### Methodology
#### Features and Design

- The robotic platform can actuate two DOF of the ankle, dorsiflexion–plantarflexion (DP) in the sagittal plane and inversion–eversion (IE) in the frontal plane.
- The platform has a wide range of motion (ROM): 30° for DP and 20° for IE.
- It simulates a wide range of mechanical (haptic) environments, from compliant to highly stiff.
- It can apply position perturbations up to 100°/s to elicit reflex responses and enable a refined characterization of intrinsic and reflexive ankle mechanics.
- The platform can provide the necessary torque to support and perturb a subject weighing up to 100 kg during dynamic tasks.

The platform was designed to address the limitations of previous devices by incorporating features that allow for a comprehensive assessment of ankle mechanics under a variety of conditions and during dynamic tasks.

#### Validation Experiments

A series of validation experiments were conducted to demonstrate the capabilities of the robotic platform. These tests examined the platform's ability to provide accurate position perturbations to the ankle, simulate a wide range of mechanical environments, and estimate the impedance of the ankle joint. The experiments were performed in both DOF of the ankle.

### Results

The robotic platform demonstrated high accuracy in providing position perturbations, simulating different haptic environments, and estimating ankle impedance. Key findings include:

- The platform accurately provided both slow sinusoidal perturbations and fast ramp-and-hold perturbations with minimal error, even under substantial loading.
- The platform dynamics were primarily dominated by inertia, behaving as a rigid body.
- It could simulate a wide range of haptic environments (50-2000 Nm/rad) with high accuracy.
- Impedance estimation of a physical mockup resembling the human foot-ankle complex was accurate using both slow sinusoidal and fast ramp-and-hold perturbations.
- A pilot human study showed that intrinsic ankle impedance and energetic passivity during quiet standing could be reliably quantified in both DOF using the platform.

### Conclusion

The comprehensive characterization of multi-dimensional ankle mechanics using this robotic platform provides **valuable insights for the design and control of lower extremity robots**, such as ankle-foot orthoses, exoskeletons, and prostheses.

- The directional characteristics of ankle impedance, with consistently lower impedance in IE than DP, suggest optimizing robot design with lower mass distribution along IE and using a lightweight actuator with lower torque capacity for IE.
- The finding that human ankle impedance can be accurately approximated by a second-order system in both DOF simplifies the development of a biomimetic impedance controller for robotic ankles with controllable stiffness and damping.
- The quantification of ankle passivity can inform the balance between performance and coupled stability of the human-robot system, allowing for adjustments to the robotic ankle impedance based on the level of human ankle dissipation in a given task.
- The directional characteristics of ankle passivity, with higher passivity in DP than IE, enable refined tuning of the robotic ankle impedance in the IE-DP space, allowing for relaxation of the passivity constraint in DP while exercising caution in IE.

Overall, the multi-axis robotic platform presented in this paper enables a comprehensive characterization of human ankle mechanics, informing the design and control of lower extremity robots to improve their performance and stability during interaction with humans.


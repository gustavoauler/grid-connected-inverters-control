# Current Control of the Three-phase LCL filter
For the next step, it was chosen to simulate a circuit similar to the previous one, but this time in three phases. This evolution proves to be a bit more complex, as the currents need to undergo the abc/dq transformation to be controlled. In the other hand, by transforming a sinusoidal signal into a continuos one, it enables PI controllers to be used instead of ressonant controllers. The plant that will be studied can be seen below.
![image](https://github.com/gustavoauler/grid-connected-inverters-control/assets/113851430/6b2a1ace-39e9-44a6-af25-f213124b5c4f)
## Tranformations
To perform the Clarke and Park (abc/dq) tranformations, it is necessary to perform a Phased Locked Loop (PLL), since one of the criteria for connecting systems to the grid is to ensure that the injected current has the same frequency as the grid. A PLL is a circuit which has the goal of matching the frequency of an input signal. This is really important for noisy circuits, whose frequency can oscilate over time. In the LCL filter context, the PLL will be useful for performing the (abc/dq) tranformation, since it requires the angle of the AC voltage, which can be obtained by integrating \omega given by the PLL.

The Clarke and Park transformations are mathematical transformations commonly used in the field of power electronics and control systems. These transformations are particularly relevant in the context of three-phase electrical systems, where they help simplify analysis and control. The Clarke transformation is used to convert a three-phase system into a two-dimensional system, simplifying the representation of the system in analysis and control. The transformation can be done by solving the matrix:
![image](https://github.com/gustavoauler/grid-connected-inverters-control/assets/113851430/c181619b-26c0-4f77-acd4-1e94a8080fa2)

The Park transformation, also known as the dq0 transformation, is used to convert the three-phase system (in a stationary reference frame) into a two-dimensional rotating frame. It uses the outputs of the Clarke tranformation on its entries, as it can be seen below:

![image](https://github.com/gustavoauler/grid-connected-inverters-control/assets/113851430/0d94fefe-91ec-492b-9a53-9afbb6fad82b)
## Control Block
By performing the abc/dq tranformation, it will generate a signal with continuos behaviour, which means it can be tracked correctly by a PI controller. That means that the input of the control block must also be a continuos signal, containing the current. The grid currents are used as inputs to the abc of the Clarke and Park transforms, and the grid voltages are used as inputs to the abc of the Clarke transform, whose outputs are inputs to the PLL, resulting in the output angle ωt, or θ, used for the Park transform for the current.
The outputs $i_d$ and $i_q$ serve as feedback for control loops 1 and 2, respectively. The set-point for $i_d$ represents the desired active current on the grid, and the $i_q$ represents the desired reactive current. The PI controller is used to make the error tend to zero. Additionally, the output signal undergoes the inverse transform dq/abc, and the output signals of this transform are used as control inputs for the controlled voltage sources representing the converter. 
On the 'PSIM' folder, a simulation of this circuit can be seen on 'LCL_Three' file.

## IGBT
To enhance the model in the previous section, a PWM control signal will be used, connected to the inputs of the voltage inverter, which will produce alternating current through direct current. Thus, a single voltage source, $V_dc$, representing, for example, the wind power generation, will be connected to the inverter. The inverter, driven by PWM input signals from the control block, will generate the necessary current to control the system. The operating principle of the Insulated Gate Bipolar Transistor (IGBT) can be seen in the following figure:
![image](https://github.com/gustavoauler/grid-connected-inverters-control/assets/113851430/eb535105-89a2-4365-ac96-7f3b0e2ca12f)
To generate a sinusoidal signal, it uses multiple pulses with different periods, causing the average value to be the sin wave. To see the Three-Phase LCL filter with PWM, check the file 'LCL_Three_PWM' on the 'PSIM' folder.

## Simulink
Finally, to ease the process of tunning the controller, the last circuit was converted to simulink. On this file, the PLL and Inverter are done manually, when on PSIM the blocks are already available. The electrical libraries are required.
To see the simulation, open the 'Simulink' folder and check de 'lcl' file.
